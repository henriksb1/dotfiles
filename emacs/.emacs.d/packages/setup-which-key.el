(provide 'setup-which-key)

(use-package which-key
  :defer 2
  :init
  ;; Wait 3 seconds before opening normally.
  (setq which-key-idle-delay 2)

  ;; Allow F1 to trigger which-key before it is done automatically
  (setq which-key-show-early-on-C-h t)

  ;; Refresh quickly once it is open
  (setq which-key-idle-secondary-delay 0.05)

  :config
  (which-key-mode)

  :diminish which-key-mode)
