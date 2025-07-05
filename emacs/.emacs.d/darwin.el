(provide 'darwin)

;; Setup environment variables from the user's shell.
(use-package exec-path-from-shell
  :init
  (exec-path-from-shell-initialize))
