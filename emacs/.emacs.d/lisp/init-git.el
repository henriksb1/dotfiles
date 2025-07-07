(use-package magit
  :defer t

  :custom
  (magit-section-initial-visibility-alist '((untracked . show)
                                            (unstaged . show)
                                            (unpushed . show)
                                            (unpulled . show)
                                            (stashes . show)))
  (magit-no-confirm '(stage-all-changes
                      unstage-all-changes))

  :bind (("C-x m" . magit-status))

  :config
  ;; move cursor into position when entering commit message
  (add-hook 'git-commit-mode-hook 'my/magit-cursor-fix))

(defun my/magit-cursor-fix ()
  (beginning-of-buffer)
  (when (looking-at "#")
    (while (looking-at "#")
      (forward-line))
    (forward-line)))

(use-package forge
  :after magit
  :defer t)

(use-package diff-hl
  :defer 2
  :config
  (global-diff-hl-mode)
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(provide 'init-git)