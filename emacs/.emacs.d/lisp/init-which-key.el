(use-package which-key
  :defer 2
  :init
  (setq which-key-idle-delay 1.5)

  :config
  (which-key-mode)

  :diminish which-key-mode)

(provide 'init-which-key)