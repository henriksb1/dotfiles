;; Install and configure projectile for project search
(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
   :bind (:map projectile-mode-map
            ("C-c p f" . projectile-find-file)
            ("C-c p s" . projectile-ripgrep)
            ("C-c p p" . projectile-switch-project)))

(setq projectile-project-search-path '("~/projects"))

(setq projectile-mode-line
      '(:eval (format " Projectile[%s]" (projectile-project-name))))

;; Install and configure swiper for current file search
(use-package swiper
  :ensure t
  :bind (("C-s" . swiper)))

(provide 'init-projectile)