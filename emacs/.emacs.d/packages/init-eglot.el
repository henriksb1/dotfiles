(use-package typescript-mode
  :ensure t)

(use-package eglot
  :hook ((js-mode . eglot-ensure)
         (typescript-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs
              '((js-mode typescript-mode)
                . ("typescript-language-server" "--stdio"))))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(setq eglot-ignored-server-capabilities '(:diagnosticProvider))

(provide 'init-eglot)