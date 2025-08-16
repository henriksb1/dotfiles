(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'")

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save))
  :bind (:map tide-mode-map
              ("M-." . tide-jump-to-definition)
              ("M-," . tide-jump-back)
              ("C-c C-r" . tide-rename-symbol)
              ("C-c C-f" . tide-references)
              ("C-c C-d" . tide-documentation-at-point)
              ("C-c C-e" . tide-error-at-point)
              ("C-c C-t" . tide-fix)))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package prettier-js
  :ensure t
  :hook (typescript-mode . prettier-js-mode))

(provide 'init-typescript)