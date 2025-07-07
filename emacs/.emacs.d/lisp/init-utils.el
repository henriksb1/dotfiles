(defun my/reload-init ()
  "Reload Emacs configuration."
  (interactive)
  (load-file user-init-file))

(defun my/open-config ()
  "Open init.el for quick editing."
  (interactive)
  (find-file user-init-file))

(provide 'init-utils)