(setq custom-file "~/.emacs_files/emacs-custom")
(load custom-file)

(setq whitespace-file "~/.emacs_files/whitespace.el")
(load whitespace-file)

(setq skeleton-file "~/.emacs_files/skeleton.el")
(load skeleton-file)

(package-initialize)

;; show matching parens
(show-paren-mode t)

;; rainbow delimiter
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; give the number of the column
(column-number-mode t)

;; put the lines numbers on the side
(global-linum-mode 1)

;; allow to use the mouse on emacs
(xterm-mouse-mode 1)

;; put a limit of 80 caracters by line
  ;; (setq-default fill-column 80)
  ;; (setq-default auto-fill-function 'do-auto-fill)

;;show the caracters which are after 80 column
(setq whitespace-line-column 80)
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)
(global-whitespace-mode +1)

;; scrol with mouse
(global-set-key (kbd "<C-mouse-4>") 'scroll-down-line)
(global-set-key (kbd "<C-mouse-5>") 'scroll-up-line)
(global-set-key (kbd "<mouse-4>") 'previous-line)
(global-set-key (kbd "<mouse-5>") 'next-line)

;; put the bar on the left side of emacs
(setq linum-format "%3d\u2502 ")

;; Drag-stuff - Drag lines and regions
(drag-stuff-global-mode 1)

;; Use C-S-up/down
(setq drag-stuff-modifier '(M))
(define-key drag-stuff-mode-map (drag-stuff--kbd 'up) 'drag-stuff-up)
(define-key drag-stuff-mode-map (drag-stuff--kbd 'down) 'drag-stuff-down)

;; highlight the current line
(global-hl-line-mode 1)
;;(set-face-background 'hl-line "#607571")

;; automaticaly close (, { and [
(electric-pair-mode +1)

;; do an automatic indentation
(global-set-key (kbd "RET") 'newline-and-indent)

;; Colorise en Rouge les espace
(setq show-trailing-whitespace t)
(setq-default show-trailing-whitespace t)

;; Remplacer le texte selectionne si on tape
(delete-selection-mode t)

;; The following 3 lines disable unnecessary GUI elements, in this case the
;; menu bar, the tool bar and the scroll bar. If you wish, you can comment out
;; the menu-bar and keep it, but eventually I recommend you disable it.
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; We don't need the Emacs splash screen. You can keep it on if you're into
;; that sort of thing
(setq inhibit-splash-screen t)

;;; I prefer to make the default font slightly smaller.
(set-face-attribute 'default nil :height 90)

;; By default C-x o is bound to 'other window, but I find I use it much more
;; ofther than open-line, which is bound to C-o, so I swap their definitions
(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "C-x o") 'open-line)

;; allows to modify compressed file
(auto-compression-mode t)

;; change yes or no to y or n
(fset 'yes-or-no-p 'y-or-n-p)

;; smart begining of line
(defun smart-beginning-of-line ()
  (interactive "^")
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))
(global-set-key (kbd "<home>") 'smart-beginning-of-line)

;; Duplicate line with C-S-d
(defun duplicate-current-line-or-region (arg)
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))
(global-set-key (kbd "C-c d") 'duplicate-current-line-or-region)

;; Set C-c, C-x, C-v just to be in sync with the rest of the world
;; (cua-mode t)

;; Spell check
(global-set-key (kbd "<f6>") 'flyspell-mode)

;; Spell check with hunspell
(when (executable-find "hunspell")
  (setq-default ispell-program-name "hunspell")
  (setq ispell-really-hunspell t))

;; Multiple cursors
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;; recentf stuff
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(run-at-time nil (* 5 60) 'recentf-save-list)
(recentf-cleanup)
(setq recentf-exclude '("*"))

;; Making it easier to discover Emacs key presses.
(which-key-mode)
(which-key-setup-side-window-bottom)
(setq which-key-idle-delay 0.05)

;; auto-completion
(ac-config-default)
;; (yas-global-mode 1)

;; whitespace
(autoload 'nuke-trailing-whitespace "whitespace" nil t)
(add-hook 'write-file-hooks 'nuke-trailing-whitespace)

;; Makefile auto
(global-set-key (kbd "C-x C-m") 'create-makefile)

;; .h auto
(global-set-key (kbd "C-x C-l") 'insert-h-header)

;; Launch the man
(defun vectra-man-on-word ()
  "Appelle le man sur le mot pointe par le curseur"
  (interactive)
  (manual-entry (current-word)))
(global-set-key (kbd "C-x C-m") 'vectra-man-on-word)

;; Supprime les fichier ~
(setq make-backup-files nil)

;; Reduit la fontion sur elle meme
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'lisp-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'python-mode-hook 'hs-minor-mode)
(global-set-key (kbd "<f2>") 'hs-hide-block)
(global-set-key (kbd "<f3>") 'hs-show-block)
