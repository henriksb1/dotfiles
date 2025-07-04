(provide 'keybindings)

;; C-z by default suspends the session
(bind-key* "C-z" 'undo)

;; Clever newlines
(global-set-key (kbd "C-o") 'open-line-and-indent)
(global-set-key (kbd "<C-return>") 'open-line-below)
(global-set-key (kbd "<C-S-return>") 'open-line-above)

;: Keep them windows nice and balanced
(global-set-key (kbd "C-x 0") 'my/delete-window)
(global-set-key (kbd "C-x 3") 'my/split-window-right)

;; Copy to end of current line if no region
(global-set-key (kbd "M-w") 'copy-region-or-current-line)

;; Navigate paragraphs
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)

;; Move whole lines
(global-set-key (kbd "<C-S-down>") 'move-text-down)
(global-set-key (kbd "<C-S-up>") 'move-text-up)

;; Create scratch buffer
(global-set-key (kbd "C-c b") 'create-scratch-buffer)

;; Easy window switching with M-<direction>
(use-package windmove
  :ensure nil ; built-in
  :bind* (("<M-left>" . windmove-left)
	 ("<M-up>" . windmove-up)
	 ("<M-right>" . windmove-right)
	 ("<M-down>" . windmove-down)))

;; Don't zoom individual buffers
(global-unset-key (kbd "C-x C-+"))

(defun inc-number-at-point (arg)
  (interactive "p")
  (unless (or (looking-at "[0-9]")
              (looking-back "[0-9]"))
    (goto-closest-number))
  (save-excursion
    (while (looking-back "[0-9]")
      (forward-char -1))
    (re-search-forward "[0-9]+" nil)
    (replace-match (incs (match-string 0) arg) nil nil)))

(defun dec-number-at-point (arg)
  (interactive "p")
  (inc-number-at-point (- arg)))

(defun copy-to-end-of-line ()
  (interactive)
  (kill-ring-save (point)
                  (line-end-position))
  (message "Copied to end of line"))

(defun copy-region-or-current-line ()
  (interactive)
  (if (region-active-p)
      (kill-ring-save (region-beginning) (region-end))
    (copy-to-end-of-line)))

(defun open-line-and-indent ()
  (interactive)
  (newline-and-indent)
  (end-of-line 0)
  (indent-for-tab-command))

(defun open-line-below ()
  (interactive)
  (end-of-line)
  (newline)
  (indent-for-tab-command))

(defun open-line-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command))

(defun my/delete-window ()
  (interactive)
  (delete-window)
  (balance-windows))

(defun my/split-window-right ()
  (interactive)
  (split-window-right)
  (windmove-right)
  (balance-windows))

(defun create-scratch-buffer ()
  "Create a new scratch buffer to work in. (could be *scratch* - *scratchX*)"
  (interactive)
  (let ((n 0)
        bufname)
    (while (progn
            (setq bufname (concat "*scratch"
                                  (if (= n 0) "" (int-to-string n))
                                  "*"))
            (setq n (1+ n))
            (get-buffer bufname)))
    (switch-to-buffer (get-buffer-create bufname))
    (emacs-lisp-mode)))