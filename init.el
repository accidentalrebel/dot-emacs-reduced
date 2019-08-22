;;; Init ==========================================================

(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/"))

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

(use-package golden-ratio
  :config
  (golden-ratio-mode))

(use-package smex)
(use-package avy
  :bind(("C-," . avy-goto-char-2)
	("C-;" . avy-goto-word-1)
	("C-'" . avy-goto-line)))

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
(set-face-attribute 'default nil :height 110 :weight 'bold :font "DejaVu Sans Mono")

;;; Setting up ==========================================================
(when (file-exists-p "~/.emacs.d/arebel.el")
  (load "~/.emacs.d/arebel.el"))

;;; Editor ==========================================================

;; Get more screen space
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode 1)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;; Custom Set Variables ==========================================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(elfeed php-mode hackernews lua-mode multi-term pelican-mode twittering-mode calfw arduino-mode company-jedi oauth sudo-edit org calfw-org calfw-cal exec-path-from-shell markdown-mode undo-tree ripgrep company omnisharp flycheck nim-mode counsel-projectile projectile ac-ispell counsel swiper csharp-mode org-journal magit ivy eww-lnum avy use-package smex golden-ratio bind-key))
 '(projectile-mode t nil (projectile))
 '(show-paren-mode t)
 '(smartparens-global-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
