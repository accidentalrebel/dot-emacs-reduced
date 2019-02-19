;;; Init ==========================================================

(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/"))

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
(use-package sudo-edit)

(use-package eww-lnum
  :bind(:map eww-mode-map
	     ("f" . eww-lnum-follow)
	     ("F" . eww-lnum-universal)))

(use-package recentf-mode
  :bind(("C-c r" . counsel-recentf)))

(add-to-list 'load-path "~/development/projects/elisp")

(use-package alert
  :commands (alert)
  :init
  (setq alert-default-style 'message))

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
(bind-key "C-c e s" 'eshell)
(bind-key "C-x e" 'other-frame)
(bind-key "C-c C-v" 'revert-buffer)
(fset 'yes-or-no-p 'y-or-n-p)

;;; Theme ==========================================================
(load-theme 'deeper-blue)
(set-face-attribute 'default nil :height 110 :weight 'bold :font "DejaVu Sans Mono")

;;; Auth ==========================================================
(when (file-exists-p "~/.emacs.d/auth.el")
  (load "~/.emacs.d/auth.el"))

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
	 ("C-c c" . org-capture)))

(use-package org-journal
  :after org
  :init
  (setq org-journal-dir "~/org/journals/")
  (setq org-journal-file-format "%Y%m%d.org"))

;; (use-package calfw)
;; (use-package calfw-org)

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

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode))

(use-package company
  :config
  (add-to-list 'company-backends #'company-omnisharp)
  (add-to-list 'company-backends #'company-jedi)
  :hook ((csharp-mode . company-mode)
	 (python-mode . company-mode)))

(use-package omnisharp
  :init
  (setq omnisharp-server-executable-path "/home/arebel/development/tools/omnisharp/run")
  :hook (csharp-mode . omnisharp-mode)
  :bind (("C-c C-e" . omnisharp-run-code-action-refactoring)
	 ("C-c C-s" . omnisharp-reload-solution)))

(use-package projectile
  :bind (("C-c C-f" . projectile-find-file)
	 ("C-c C-r" . projectile-ripgrep)))

(use-package jedi
  :bind (("M-s d" . jedi:goto-definition)))

(modify-coding-system-alist 'file "\\.C\\'" 'utf-8-dos)
(modify-coding-system-alist 'file "\\.H\\'" 'utf-8-dos)

;;; Slack ==========================================================
(use-package slack
  :commands (slack-start)
  :config
   (slack-register-team
   :name "mindcake-slack"
   :default t
   :client-id auth--slack-client-id
   :client-secret auth--slack-client-secret
   :token auth--slack-client-token
   :subscribed-channels '(chefwars_dev)
   :full-and-display-names t))

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
    (oauth slack jedi sudo-edit org calfw-org calfw-cal calfw exec-path-from-shell company-jedi markdown-mode undo-tree ripgrep company omnisharp flycheck nim-mode counsel-projectile projectile ac-ispell counsel swiper csharp-mode org-journal magit ivy eww-lnum avy use-package smex golden-ratio bind-key)))
 '(projectile-mode t nil (projectile))
 '(show-paren-mode t)
 '(smartparens-global-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
