;;; py-rope.el --- Use rope to refactor a Python buffer

;; Copyright (C) 2017, Todd Dembrey <todd.dembrey@gmail.com>

;; Author: Todd Dembrey <todd.dembrey@gmail.com>
;; Version: 0.0.1

;;; Commentary:

;; Provides commands, which use the external "rope" tool
;; to refactor Python code.

;;; Code:

;;;###autoload
(defun py-rope-test ()
  "Print a message."
  (interactive)
  (message "%s" (projectile-project-root))
)

(provide 'py-rope)
;;; py-rope.el ends here
