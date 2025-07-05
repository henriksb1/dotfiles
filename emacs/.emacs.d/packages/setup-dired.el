(provide 'setup-dired)

(with-eval-after-load 'dired
  (setq dired-free-space nil
        dired-dwim-target t  ; Propose a target for intelligent moving/copying
        dired-deletion-confirmer 'y-or-n-p
        dired-filter-verbose nil
        dired-recursive-deletes 'top
        dired-recursive-copies 'always
        dired-create-destination-dirs 'ask)

  ;; This is a higher-level predicate that wraps `dired-directory-changed-p'
  ;; with additional logic. This `dired-buffer-stale-p' predicate handles remote
  ;; files, wdired, unreadable dirs, and delegates to dired-directory-changed-p
  ;; for modification checks.
  (setq dired-auto-revert-buffer 'dired-buffer-stale-p)

  (setq dired-vc-rename-file t)

  ;; Disable the prompt about killing the Dired buffer for a deleted directory.
  (setq dired-clean-confirm-killing-deleted-buffers nil)

  ;; dired-omit-mode
  (setq dired-omit-verbose nil)
  (setq dired-omit-files (concat "\\`[.]\\'")))
