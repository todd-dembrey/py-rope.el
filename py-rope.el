;;; py-rope.el --- Use rope to refactor a Python buffer

;; Copyright (C) 2017, Todd Dembrey <todd.dembrey@gmail.com>

;; Author: Todd Dembrey <todd.dembrey@gmail.com>
;; Version: 0.0.1

;;; Commentary:

;; Provides commands, which use the external "rope" tool
;; to refactor Python code.

;;; Code:

;;;###autoload
(defun py-rope-test (beginning end)
  "Extract a variable."
  (interactive "r")
  (message "%s" (buffer-file-name))
  (call-process "python" nil t t "./el_rope.py"
                (projectile-project-root)
                (buffer-file-name)
                (number-to-string beginning)
                (number-to-string end)
                )
)

(provide 'py-rope)
;;; py-rope.el ends here
