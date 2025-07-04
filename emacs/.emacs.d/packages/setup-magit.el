(provide 'setup-magit)

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

  :bind (("C-x m" . magit-status)
         (:map magit-status-mode-map
               ("q" . magit-quit)))

  :config
  (wrap-fullscreen magit-status)
  (wrap-fullscreen magit-init)

  ;; move cursor into position when entering commit message
  (add-hook 'git-commit-mode-hook 'my/magit-cursor-fix))

(defun kill-magit-buffers ()
  (let ((current (current-buffer)))
    (dolist (buf (magit-mode-get-buffers))
      (unless (eq buf current)
        (kill-buffer buf)))))

(defun magit-quit ()
  "Like magit-mode-bury-buffer, but also restores the window
configuration stored by magit-status-fullscreen"
  (interactive)
  (let ((prev my/previous-window-configuration))
    (kill-magit-buffers)
    (funcall magit-bury-buffer-function 'kill-buffer)
    (when prev (register-val-jump-to prev nil))))

(defun is-commit-message-buffer? ()
  (when (buffer-file-name)
    (equal (buffer-file-name-body) "COMMIT_EDITMSG")))

(defun my/magit-cursor-fix ()
  (beginning-of-buffer)
  (when (looking-at "#")
    (while (looking-at "#")
      (forward-line))
    (forward-line)))

(use-package diff-hl
  :defer 2
  :config
  (global-diff-hl-mode)
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))
