(provide 'setup-lsp)

(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'")

(use-package eglot
  :ensure t
  :hook ((js-mode . eglot-ensure)
         (typescript-mode . eglot-ensure)
         (tsx-ts-mode . eglot-ensure)
         (js-ts-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs
               '((js-mode js-ts-mode typescript-mode tsx-ts-mode)
                 . ("typescript-language-server" "--stdio"))))
