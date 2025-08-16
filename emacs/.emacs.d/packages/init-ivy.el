(use-package ivy
  :ensure t
  :init (ivy-mode 1)
  :config (setq ivy-use-virtual-buffers t
                ivy-count-format "%d/%d "))

(use-package counsel
  :ensure t
  :after ivy
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)))

(provide 'init-ivy)