(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; general settings
(require 'init-fast-startup)
(require 'init-packages)
(require 'init-emacs)
(require 'init-utils)
(require 'init-keybindings)

;; init packages
(require 'init-git)
(require 'init-vertico)
(require 'init-savehist)
(require 'init-orderless)

(provide 'init)
