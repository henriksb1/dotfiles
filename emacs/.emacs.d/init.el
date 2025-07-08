(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; general settings
(require 'init-fast-startup)
(require 'init-packages)
(require 'init-emacs)
(require 'init-utils)
(require 'init-keybindings)
(require 'init-which-key)

;; init packages
(require 'init-git)
(require 'init-org)
(require 'init-vertico)
(require 'init-savehist)
(require 'init-orderless)

(provide 'init)
