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

(when (eq system-type 'windows-system)
  (exec-path-from-shell-initialize))

;; (use-package pomidor
;;   :config (setq pomidor-sound-tick nil
;; 		pomidor-sound-tack nil))

;;; Auth ==========================================================
(when (file-exists-p "~/.emacs.d/auth.el")
  (load "~/.emacs.d/auth.el"))

;;; Org ==========================================================
(use-package org
  :init
  (setq org-default-notes-file "~/org/notes/notes.org"
	org-agenda-files (list "~/org/todos/personal.org"
			       "~/org/todos/mindcake.org"
			       "~/org/todos/3layers.org"
			       "~/org/todos/projects.org")
	org-refile-targets '(("~/org/todos/personal.org" . (:maxlevel . 1))
			     ("~/org/todos/mindcake.org" . (:maxlevel . 1))
			     ("~/org/todos/3layers.org" . (:maxlevel . 1))
			     ("~/org/todos/projects.org" . (:maxlevel . 1)))
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

;; (use-package org-crypt
;;    :ensure nil
;;    :after org
;;    :init (org-crypt-use-before-save-magic)
;;    :custom (org-crypt-key "688512E0A252F187D0DE3CEF852B098E5C4A3235"))

(use-package org-journal
  :after org
  :init
  ;; (setq org-journal-enable-encryption t)
  (setq org-journal-dir "~/org/journals/")
  (setq org-journal-file-format "%Y%m%d.org"))

;; (use-package org-tempo)

;;; Programming ==========================================================
(use-package smartparens
  :hook ((lisp-mode . smartparens-mode)))

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
  (add-to-list 'company-backends #'company-clang)
  :hook ((lua-mode . company-mode)
	 (c++-mode . company-mode)
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

(use-package cc-mode
  :preface
  (defun arebel-setup-cpp ()
    (c-set-style "linux")
    (c-set-offset 'innamespace '0)
    (c-set-offset 'inextern-lang '0)
    (c-set-offset 'inline-open '0)
    (c-set-offset 'label '*)
    (c-set-offset 'case-label '*)
    (c-set-offset 'access-label '/)
    (setq c-basic-offset 4)
    (setq tab-width 4)
    (setq indent-tabs-mode t))
  :config
  (add-hook 'c++-mode-hook #'arebel-setup-cpp)
  (add-hook 'c-mode-hook #'arebel-setup-cpp))

(use-package fic-mode
  :init
  (setq fic-highlighted-words '("FIXME" "TODO" "BUG" "NOTE"))
  :config
  (add-hook 'prog-mode-hook `fic-mode))

(setq compilation-scroll-output t)

;;; For DOS Development
(modify-coding-system-alist 'file "\\.C\\'" 'utf-8-dos)
(modify-coding-system-alist 'file "\\.H\\'" 'utf-8-dos)

;;; For MindCake Development
;; (load "/shome/development/projects/mindcake/histohunters/Assets/tools/scripts/mindcake-set-build-version.el")

;;; For Rebel Game Engine dvelopment
(when (file-exists-p "/home/arebel/development/projects/rebel-game-engine/scripts/tools/rge.el")
  (load "/home/arebel/development/projects/rebel-game-engine/scripts/tools/rge.el"))

;;; Helpful snippets ================================================

;; Found here: https://emacs.stackexchange.com/a/7479/10481
(defun find-and-compile ()
  "Traveling up the path, find a Makefile and `compile'."
  (interactive)
  (let ((cmd (read-string "find-and-compile: " compile-command)))
    (when (locate-dominating-file default-directory "Makefile")
      (with-temp-buffer
	(cd (locate-dominating-file default-directory "Makefile"))))
    (compile cmd)))
(bind-key "C-x m" `find-and-compile)

(defun query-replace-at-point ()
  "\"query-replace\" but gets the word where the cursor is."
  (interactive)
  (let ((to-replace (read-string "Query replace at point: "
				 (thing-at-point 'word)))
	(to-replace-with (read-string "Query replace at point with: ")))
    (forward-line -1)
    (query-replace to-replace to-replace-with)))
(bind-key "M-%" `query-replace-at-point)

;;; Social ==========================================================
;; (use-package twittering-mode
;;   :init
;;   (setq twittering-icon-mode t)
;;   (setq twittering-use-icon-storage t))

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

(when (file-exists-p "~/development/projects/elisp/coordinate.el/coordinate.el")
  (add-to-list 'load-path "~/development/projects/elisp/coordinate.el/coordinate")
  (load "~/development/projects/elisp/coordinate.el/coordinate.el"))

(when (not (locate-library "emacs-game-engine"))
  (add-to-list 'load-path "~/development/projects/elisp/emacs-game-engine/"))

(setq slack-cli-channels '( "bot-test-channel" "chefwars_dev" "chefwars_art"))

(setq blog-list '( "accidentalrebel.com"))

(setq elfeed-feeds
      '("https://www.rockysunico.com/feeds/posts/default?alt=rss"
	"https://factorio.com/blog/rss"))

(defun insert-current-date () (interactive)
       (insert (shell-command-to-string "echo -n $(date \"+%Y-%m-%d %H\:%M\")")))

;;; Remoting ==========================================================
(setq tramp-default-method "ssh")

(defun arebel-open-unity-editor-log()
  "Opens the unity editor log"
  (interactive)
  (find-file "~/.config/unity3d/Editor.log")
  (auto-revert-mode))
