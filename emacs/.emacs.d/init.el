(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-fast-startup)
(require 'init-straight)
(require 'init-emacs)
(require 'init-utils)
(require 'init-keybindings)
(require 'init-which-key)

;; Load all packages
(dolist (file (directory-files packages-dir t "^[^#].*el$"))
  (when (file-regular-p file)
    (load file)))