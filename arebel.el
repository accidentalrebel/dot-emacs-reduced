(show-paren-mode)

;;; Packages
(use-package eww)

(use-package eww-lnum
  :after eww
  :bind(:map eww-mode-map
	     ("f" . eww-lnum-follow)
	     ("F" . eww-lnum-universal)))

(use-package lua-mode
  :bind(:map lua-mode-map
	     ("<f5>" . compile)))

(add-to-list 'load-path "~/development/projects/elisp")

(use-package alert
  :commands (alert)
  :init
  (setq alert-default-style 'message))

(use-package swiper
  :preface
  (defun swiper-at-point ()
    (interactive)
    (swiper (thing-at-point 'word)))
  :bind (("M-s s" . swiper)
	 ("M-s M-s" . swiper-at-point)))

(use-package recentf-mode
  :bind(("C-c r" . counsel-recentf)))

;;; Auth ==========================================================
(when (file-exists-p "~/.emacs.d/auth.el")
  (load "~/.emacs.d/auth.el"))

;;; Org ==========================================================
(use-package org
  :init
  (setq org-default-notes-file "~/org/notes/notes.org"
	org-agenda-files (list "~/org/todos/todos.org"
			       "~/org/notes/mindcake/mindcake-notes.org"
			       "~/org/notes/personal/personal-notes.org"
			       "~/org/notes/projects/project-notes.org")
	org-refile-targets '(("~/org/todos/todos.org" . (:maxlevel . 1)))
	org-agenda-start-on-weekday 1
	org-todo-keywords '((sequence "TODO" "STARTED" "DONE"))
	org-todo-keyword-faces
	'(("TODO" . (:foreground "black" :background "#ff39a3" :weight bold))
	  ("STARTED" . (:foreground "black" :background "orange" :weight bold))
	  ("DONE" . (:foreground "black" :background "green" :weight bold)))
	org-tag-alist
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

;; (use-package org-tempo)

;;; Programming ==========================================================
(use-package yasnippet
  :init
  (yas-global-mode))

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode)
  :hook ((csharp-mode . flycheck-mode)))

(use-package company
  :config
  (add-to-list 'company-backends #'company-jedi)
  (add-to-list 'company-backends #'company-omnisharp)
  :hook ((lua-mode . company-mode)
	 (csharp-mode . company-mode)
	 (python-mode . jedi:setup)
	 (python-mode . company-mode)
	 (nim-mode-hook . nimsuggest-mode)))

(use-package omnisharp
  :init
  ;;(setq omnisharp-server-executable-path "/home/arebel/development/tools/omnisharp/run")
  :hook (csharp-mode . omnisharp-mode)
  :bind (("C-c C-e" . omnisharp-run-code-action-refactoring)
	 ("C-c C-s" . omnisharp-reload-solution)))

(use-package projectile
  :bind (("C-c C-f" . projectile-find-file)
	 ("C-c C-r" . projectile-ripgrep)))

(use-package jedi
  :init
  (setq jedi:complete-on-dot t)
  :bind (("M-s d" . jedi:goto-definition)))

;;; For DOS Development
(modify-coding-system-alist 'file "\\.C\\'" 'utf-8-dos)
(modify-coding-system-alist 'file "\\.H\\'" 'utf-8-dos)

;;; Social ==========================================================
;; (use-package twittering-mode
;;   :init
;;   (setq twittering-icon-mode t))

;;; Backups ==========================================================
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))

;;;
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;;; Special code ==========================================================
(when (file-exists-p "~/development/projects/python/arebel-blog-helper/arebel-blog-helper.el")
  (load "~/development/projects/python/arebel-blog-helper/arebel-blog-helper.el"))

(when (file-exists-p "~/development/projects/elisp/slack-cli/slack-cli.el")
  (load "~/development/projects/elisp/slack-cli/slack-cli.el"))

(setq slack-cli-channels '( "bot-test-channel" "chefwars_dev" "chefwars_art"))

(setq elfeed-feeds
      '("https://www.rockysunico.com/feeds/posts/default?alt=rss"))

;;; Remoting ==========================================================
(setq tramp-default-method "ssh")

(defun arebel-open-unity-editor-log()
  "Opens the unity editor log"
  (interactive)
  (find-file "~/.config/unity3d/Editor.log")
  (auto-revert-mode))
