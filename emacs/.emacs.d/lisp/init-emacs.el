;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Make Emacs use the $PATH set up by the user's shell
(when (memq window-system '(mac ns x))
  (use-package exec-path-from-shell
    :config
    (exec-path-from-shell-initialize)))

;; Keep emacs Custom-settings in separate file, not appended to init.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; No splash screen
(setq inhibit-startup-message t)

;; use 80 characters
(setq-default fill-column 80)

;; Set the font
(setq default-frame-alist '((font . "Go Mono 16")))

;; Better than the default.
(load-theme 'tango-dark t)

;; No blinking cursor.
(blink-cursor-mode 0)

;; Don't beep. Just blink the modeline on errors.
(setq ring-bell-function (lambda ()
                           (invert-face 'mode-line)
                           (run-with-timer 0.05 nil 'invert-face 'mode-line)))

;; display line numbers and column numbers in all modes
(global-display-line-numbers-mode t)
(setq column-number-mode t)

;; Of course, everything is UTF-8.
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Answering just 'y' or 'n' will do
(defalias 'yes-or-no-p 'y-or-n-p)

;; Remove text in active region if inserting text
(use-package delsel
  :defer 1
  :config (delete-selection-mode 1))

;; Save a list of recent files visited. (open recent file with C-x f)
(use-package recentf
  :defer 1 ;; Loads after 1 second of idle time.
  :config (recentf-mode 1)
  :custom (recentf-max-saved-items 100))  ;; just 20 is too recent

;; Don't visually break lines for me
;;(setq-default truncate-lines t)

;; Don’t ask to create parent directories when saving files
(add-hook 'before-save-hook
          (lambda ()
            (when buffer-file-name
              (let ((dir (file-name-directory buffer-file-name)))
                (when (not (file-exists-p dir))
                  (make-directory dir t))))))

;; Always show the buffer name in the frame title (Emacs default is to show the
;; hostname when there is only one frame).
(setq frame-title-format
      (setq icon-title-format
	    '((:eval (if (buffer-file-name)
			 (abbreviate-file-name (buffer-file-name))
		       "%b"))
	      (:eval (if (buffer-modified-p)
			 "*"))
	      " - Emacs")
	    ))

(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Add final newlines to all files by default
(setq require-final-newline t)

;; Don't write lock-files, I'm the only one here
(setq create-lockfiles nil)

(provide 'init-emacs)