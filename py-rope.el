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

(provide 'py-rope)
;;; py-rope.el ends here
