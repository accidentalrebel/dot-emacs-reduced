;;; Init ==========================================================

(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
;; (add-to-list 'package-archives
;; 	     '("melpa-stable" . "http://stable.melpa.org/packages/"))
;; (add-to-list 'package-archives
;; 	     '("org" . "http://orgmode.org/elpa/"))

;;; Keybindings ==========================================================

(setq mac-command-modifier 'control)

;; Exchang C-x to C-b
(keyboard-translate ?\C-x ?\C-b)
(keyboard-translate ?\C-b ?\C-x)
;; Exchange M-x to M-b
(define-key key-translation-map [?\M-x] [?\M-b])
(define-key key-translation-map [?\M-b] [?\M-x])

(bind-key "C-c C-b" 'eval-buffer)
(bind-key "C-z" 'undo)
(bind-key "C-c f" 'find-file)
(bind-key "C-c e s" 'multi-term)
(bind-key "C-x e" 'other-frame)
(bind-key "C-c C-v" 'revert-buffer)

(fset 'yes-or-no-p 'y-or-n-p)

;;; Packages ==========================================================

(require 'use-package)
(use-package bind-key)
(use-package multi-term)

(use-package golden-ratio
  :init
  (setq golden-ratio-auto-scale nil
	golden-ratio-adjust-factor 1)
  :config
  (golden-ratio-mode))

(use-package smex)
(use-package avy
  :bind(("C-." . avy-goto-char-2)
	("C-," . avy-goto-word-1)
	("C-'" . avy-goto-line)))

(use-package ace-window
  :bind(("C-;" . ace-window)))

(use-package ivy
  :init
  (setq ivy-count-format "(%d/%d) ")
  :config
  (ivy-mode))

(use-package sudo-edit)

(use-package counsel
  :config
  (counsel-mode))

(use-package magit
  :bind (("C-x g" . magit-status)))

(use-package undo-tree
  :config
  (global-undo-tree-mode))

;;; Theme ==========================================================
(load-theme 'deeper-blue)
(set-face-attribute 'default nil :height 108 :weight 'normal :font "DejaVu Sans Mono")

;;; Term ==========================================================
(defun term-send-C-x ()
  (interactive)
  (term-send-raw-string "\C-x"))

;;; Setting up ==========================================================
(when (file-exists-p "~/.emacs.d/arebel.el")
  (load "~/.emacs.d/arebel.el"))

;;; Editor ==========================================================

;; Get more screen space
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode 1)
(column-number-mode)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;; Custom Set Variables ==========================================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(asana-my-user-task-list-gid "36614033405452" t)
 '(asana-selected-workspace-gid "36614015217976" t)
 '(asana-selected-workspace-name "Mindcake Games" t)
 '(auth-source-save-behavior nil)
 '(package-selected-packages
   '(rainbow-delimiters smartparens elpy alert pomidor paredit edit-indirect ace-window fic-mode helm jedi omnisharp yasnippet-classic-snippets yasnippet csharp-mode speed-type elfeed php-mode hackernews lua-mode multi-term pelican-mode twittering-mode calfw arduino-mode company-jedi oauth sudo-edit org calfw-org calfw-cal exec-path-from-shell markdown-mode undo-tree ripgrep company flycheck nim-mode counsel-projectile projectile ac-ispell counsel swiper org-journal magit ivy eww-lnum avy use-package smex golden-ratio bind-key))
 '(projectile-mode t nil (projectile))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
