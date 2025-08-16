(use-package magit
  :defer t

  :custom
  (magit-section-initial-visibility-alist '((untracked . show)
                                            (unstaged . show)
                                            (unpushed . show)
                                            (unpulled . show)
                                            (stashes . show)))
  (magit-diff-refine-hunk t)
  (magit-push-always-verify nil)
  (magit-revert-buffers 'silent)
  (magit-no-confirm '(stage-all-changes
                      unstage-all-changes))

  :bind (("C-x m" . magit-status)))

(use-package forge
  :after magit
  :defer t)

(use-package diff-hl
  :defer 2
  :config
  (global-diff-hl-mode)
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(provide 'init-magit)