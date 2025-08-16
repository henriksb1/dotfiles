;; Set Garbage Collection threshold extremely high (1 GB),
;; but run Garbage Collection when Emacs loses focuses:
;; https://news.ycombinator.com/item?id=39190110
(setq gc-cons-threshold 1073741824)
(add-function :after
              after-focus-change-function
              (lambda () (unless (frame-focus-state) (garbage-collect))))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(setq packages-dir (expand-file-name "packages" user-emacs-directory))
(add-to-list 'load-path packages-dir)

(require 'early-init)
(require 'init-straight)
(require 'init-emacs)
(require 'init-utils)
(require 'init-buffers)
(require 'init-keybindings)
(when (string= "darwin" system-type)
  (require 'init-osx))

;; Load all packages
(dolist (file (directory-files packages-dir t "^[^#].*el$"))
  (when (file-regular-p file)
    (load file)))