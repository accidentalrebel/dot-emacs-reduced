;;; Init ==========================================================

(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/"))

;;; Packages ==========================================================

(require 'use-package)

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

(use-package bind-key)

(use-package eww-lnum
  :bind(:map eww-mode-map
	     ("f" . eww-lnum-follow)
	     ("F" . eww-lnum-universal)))

(use-package recentf-mode
  :bind(("C-c r" . counsel-recentf)))

(add-to-list 'load-path "~/development/projects/elisp")

;;; Keybindings ==========================================================

;; Exchang C-x to C-b
(keyboard-translate ?\C-x ?\C-b)
(keyboard-translate ?\C-b ?\C-x)
;; Exchange M-x to M-b
(define-key key-translation-map [?\M-x] [?\M-b])
(define-key key-translation-map [?\M-b] [?\M-x])

(bind-key "C-c C-b" 'eval-buffer)
(bind-key "C-z" 'undo)
(bind-key "C-c f" 'find-file)
(bind-key "C-c e s" 'eshell)
(bind-key "C-x e" 'other-frame)
(fset 'yes-or-no-p 'y-or-n-p)

;;; Theme ==========================================================
(load-theme 'wombat)

;;; Editing ==========================================================
(use-package swiper
  :preface
  (defun swiper-at-point ()
    (interactive)
    (swiper (thing-at-point 'word)))
  :bind (("M-s s" . swiper)
	 ("M-s M-s" . swiper-at-point)))

(use-package magit
  :bind (("C-x g" . magit-status)))

(use-package undo-tree
  :config
  (global-undo-tree-mode))

(use-package counsel
  :config
  (counsel-mode))

(show-paren-mode)

;;; Org ==========================================================
(use-package org-journal
  :init
  (setq org-journal-dir "~/org/journals/")
  (setq org-journal-file-format "%Y%m%d.org"))

(use-package org
  :init
  (setq org-default-notes-file "~/org/notes/notes.org"
	org-agenda-files (list "~/org/notes/mindcake/mindcake-notes.org"
			       "~/org/notes/personal/personal-notes.org"
			       "~/org/notes/stream/stream-notes.org")
	org-refile-targets '((org-agenda-files . (:maxlevel . 1)))
	org-agenda-start-on-weekday 1)
  (setq org-tag-alist
	'(("achievement" . ?a)
	  ("business" . ?b)
	  ("dev" . ?d)
	  ("emacs" . ?e)
	  ("family" . ?f)
	  ("games" . ?g)
	  ("dianne" . ?i)
	  ("books" . ?k)
	  ("mindcake" . ?m)
	  ("nsfw" . ?n)
	  ("goals" . ?o)
	  ("productivity" . ?p)
	  ("rant" . ?r)
	  ("technical" . ?t)
	  ("tv" . ?v)))
  :bind (("C-c a" . org-agenda)
	 ("C-c c" . org-capture))
  )

;;; Remoting ==========================================================

(setq tramp-default-method "ssh")

;;; Editor ==========================================================

;; Get more screen space
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode 1)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;; Programming ==========================================================

(modify-coding-system-alist 'file "\\.C\\'" 'utf-8-dos)
(modify-coding-system-alist 'file "\\.H\\'" 'utf-8-dos)

;;; Twitch ==========================================================
(load-file "~/development/projects/twitch/rebeldebot/rebeldebot.el")

;;; Backups ==========================================================
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))

;;; Custom Set Variables ==========================================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flycheck nim-mode counsel-projectile projectile ac-ispell counsel undo-tree swiper csharp-mode org-journal magit ivy eww-lnum avy use-package smex golden-ratio bind-key)))
 '(projectile-mode t nil (projectile))
 '(show-paren-mode t)
 '(smartparens-global-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
