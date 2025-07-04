;; Add settings to load-path
(add-to-list 'load-path (expand-file-name "settings" user-emacs-directory))

;; Keep emacs Custom-settings in separate file, not appended to init.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Lets start with a smattering of sanity
(require 'sane-defaults)

;; Optimize startup of Emacs
(require 'fast-startup)

;; Set up appearance early
(require 'appearance)

;; Configure the package manager
(require 'packages)

;; Set up tooling for the rest of the configuration
(require 'tooling)

;; Load settings
(require 'keybindings)

;; Load all packages
(dolist (file (directory-files packages-dir t "^[^#].*el$"))
  (when (file-regular-p file)
    (load file)))