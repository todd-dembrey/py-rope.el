;;; py-rope.el --- Use rope to refactor a Python buffer

;; Copyright (C) 2017, Todd Dembrey <todd.dembrey@gmail.com>

;; Author: Todd Dembrey <todd.dembrey@gmail.com>
;; Version: 0.0.1

;;; Commentary:

;; Provides commands, which use the external "rope" tool
;; to refactor Python code.

;;; Code:

;;;###autoload
(defun py-rope-extract-variable (new-variable-name beginning end)
  "Extract a variable."
  (interactive "sNew Variable Name: \nr")
  (call-process "python" nil t t "./el_rope.py"
                (projectile-project-root)
                (buffer-file-name)
                (number-to-string beginning)
                (number-to-string end)
                new-variable-name
                )
)

(defun py-rope--call-executable)


(defun py-rope--call (file &rest args)
  (py-rope--apply-executable-to-buffer "rope"
                                       'py-rope--call-executable
                                       nil
                                       args
                                       "py"))


(defun py-rope--apply-executable-to-buffer (executable-name
                                           executable-call
                                           args
                                           only-on-region
                                           file-extension
                                           ignore-return-code)
  "Formats the current buffer according to the executable"
  (when (not (executable-find executable-name))
    (error (format "%s command not found." executable-name)))
  (let ((tmpfile (make-temp-file executable-name nil (concat "." file-extension)))
        (patchbuf (get-buffer-create (format "*%s patch*" executable-name)))
        (errbuf (get-buffer-create (format "*%s Errors*" executable-name)))
        (coding-system-for-read buffer-file-coding-system)
        (coding-system-for-write buffer-file-coding-system))
    (with-current-buffer errbuf
      (setq buffer-read-only nil)
      (erase-buffer))
    (with-current-buffer patchbuf
      (erase-buffer))

    (if (and only-on-region (use-region-p))
        (write-region (region-beginning) (region-end) tmpfile)
      (write-region nil nil tmpfile))

    (if (or (funcall executable-call errbuf tmpfile)
            (ignore-return-code))
        (if (zerop (call-process-region (point-min) (point-max) "diff" nil
                                        patchbuf nil "-n" "-" tmpfile))
            (progn
              (kill-buffer errbuf)
              (pop kill-ring)
              (message (format "Buffer is already %sed" executable-name)))

          (if only-on-region
              (buftra--replace-region tmpfile)
            (buftra--apply-rcs-patch patchbuf))

          (kill-buffer errbuf)
          (pop kill-ring)
          (message (format "Applied %s" executable-name)))
      (error (format "Could not apply %s. Check *%s Errors* for details"
                     executable-name executable-name)))
    (kill-buffer patchbuf)
    (pop kill-ring)
    (delete-file tmpfile)))

(provide 'py-rope)
;;; py-rope.el ends here
