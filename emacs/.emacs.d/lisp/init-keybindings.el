(global-set-key (kbd "<C-return>") 'my/open-line-below)
(global-set-key (kbd "<C-S-return>") 'my/open-line-above)

;; Move whole lines
(use-package move-text)
(global-set-key (kbd "<C-S-down>") 'move-text-down)
(global-set-key (kbd "<C-S-up>") 'move-text-up)

;; Navigate paragraphs
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)

;; Easy window switching with M-<direction>
(use-package windmove
  :ensure nil ; built-in
  :bind* (("<M-left>" . windmove-left)
	 ("<M-up>" . windmove-up)
	 ("<M-right>" . windmove-right)
	 ("<M-down>" . windmove-down)))

(defun my/open-line-below ()
  (interactive)
  (end-of-line)
  (newline)
  (indent-for-tab-command))

(defun my/open-line-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command))

(provide 'init-keybindings)