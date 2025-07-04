(provide 'appearance)

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen
(setq inhibit-startup-message t)

;; Don't beep. Just blink the modeline on errors.
(setq ring-bell-function (lambda ()
                           (invert-face 'mode-line)
                           (run-with-timer 0.05 nil 'invert-face 'mode-line)))

;; Just a better font
;;(setq default-frame-alist '((font . "Go Mono 8")))
(setq default-frame-alist '((font . "Go Mono 16")))

;; Better than the default.
(load-theme 'tango-dark t)

;; No blinking cursor.
(blink-cursor-mode 0)

;; display line numbers and column numbers in all modes
(setq line-number-mode t)
(setq column-number-mode t)

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

;; Disable the scroll bar by default, they flicker. Use M-x scroll-bar-mode to
;; make it re-appear.
(scroll-bar-mode -1)