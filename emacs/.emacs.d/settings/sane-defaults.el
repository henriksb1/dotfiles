(provide 'sane-defaults)

;; Of course, everything is UTF-8.
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; Don’t ask to save files before compilation, just save them.
(setq compilation-ask-about-save nil)

;; Don't visually break lines for me, please
(setq-default truncate-lines t)

;; Don’t ask to create parent directories when saving files, just
;; create them.
(add-hook 'before-save-hook
          (lambda ()
            (when buffer-file-name
              (let ((dir (file-name-directory buffer-file-name)))
                (when (not (file-exists-p dir))
                  (make-directory dir t))))))

;; Always ask for y/n, never yes/no.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Add final newlines to all files by default, not just in modes which think
;; this is useful.
(setq require-final-newline t)

;; Persistent desktops (which buffers are open)
(setq desktop-save t) ;; always save

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Don't write lock-files, I'm the only one here
(setq create-lockfiles nil)

;; Write all autosave files in the tmp dir
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;;; auto-indent for lisp modes
(defun set-newline-and-indent ()
  (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'emacs-lisp-mode-hook 'set-newline-and-indent)
(add-hook 'lisp-mode-hook 'set-newline-and-indent)
(add-hook 'scheme-mode-hook 'set-newline-and-indent)