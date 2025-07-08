(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)

(global-set-key (kbd "C-c c") 'org-capture)

(setq org-log-done t
      org-edit-timestamp-down-means-later t
      org-hide-emphasis-markers t
      org-catch-invisible-edits 'show
      org-export-coding-system 'utf-8
      org-fast-tag-selection-single-key 'expert
      org-html-validation-link nil
      org-export-kill-product-buffer-when-displayed t
      org-tags-column 80)

;; Allow using Shift + arrow keys to select text in Org-mode
(setq org-support-shift-select t)

(unless (boundp 'org-directory)
  (defvar org-directory (expand-file-name "~/org")
    "Main directory for Org files."))

(setq org-default-notes-file (expand-file-name "inbox.org" org-directory))

(setq org-capture-templates
      `(("t" "todo" entry (file org-default-notes-file)  ; use org-default-notes-file
         "* NEXT %?\n%U\n")
        ("n" "note" entry (file org-default-notes-file)
         "* %? :NOTE:\n%U\n%a\n")))

(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")))

(setq org-todo-keyword-faces
      '(("NEXT" :inherit warning)))

(provide 'init-org)