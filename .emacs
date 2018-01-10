;;;; BISHOPS PROXY

(defun bishops-proxy ()
  (setq url-proxy-services
	'(("http"     . "proxy.bws.wilts.sch.uk:8080")
	  ("https"    . "proxy.bws.wilts.sch.uk:8080")
	  ("ftp"      . "proxy.bws.wilts.sch.uk:8080")
	  ("no_proxy" . "^\\(localhost\\|10.*\\)"))
	)
  )

;;;; PERSONAL INFORMATION

(setq user-full-name "Mark Williams"
      user-mail-address "markrd.williams@gmail.com")

;;;; PACKAGE SETUP

(require 'package)

(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(setq package-enable-at-startup nil)
(package-initialize)

;; Always install use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-verbose t)
(setq use-package-always-ensure t)
(require 'use-package)

(eval-when-compile
  (require 'use-package))

;;;; GENERAL CONFIG

(menu-bar-mode -1)   ; Disable menu bar
(tool-bar-mode -1)   ; Disable tool bar
(scroll-bar-mode -1) ; Disable scroll bar

(setq inhibit-splash-screen t) ; remove startup splash screen
(setq initial-scratch-message nil) ; remove startup message


(setq scroll-step 1) ; nice scrolling
(setq scroll-conservatively 10)
(setq scroll-margin 7)

(ido-mode) ; Interactive do things (replace with ivy/helm????)

(fset 'yes-or-no-p 'y-or-n-p) ; Replace "yes or no" with "y or n"

(setq ring-bell-function 'ignore) ; Disable alarms

(setq mouse-yank-at-point t) ; Middle mouse to paste doesn't move the cursor

(setenv "GPG_AGENT_INFO" nil) ; force to use emacs password capabilities

;;;; MODE BAR

(display-time-mode 1); Show time in mode bar
(global-hl-line-mode 1) ; highlight current line
(column-number-mode 1) ; show column number


;;;; AUTOSAVES

(setq backup-directory-alist '(("." . "~/.emacs.d/backups"))) ;; backup to .emacs.d/backups
(setq delete-old-versions -1) ;; Save lots!
(setq version-control t)
(setq vc-make-backup-files t)

(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;;;; HISTORY

(setq savehist-file "~/.emacs.d/savehist") ;; save command history
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

;;;; PROGRAMMING TEXT EDITING

(electric-pair-mode 1) ;; Brackets, Quotes, etc.. match by default

(use-package evil  ;; Evil mode
  :config
  (evil-mode 1))

(use-package undo-tree  ;; Undo tree (C-x u)
  :diminish undo-tree-mode
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)))

(setq sentence-end-double-space nil) ;; sentences end with one space

(setq-default abbrev-mode t) ;; Abberviations ie "be right back"
(diminish 'abbrev-mode)
(read-abbrev-file "~/.emacs.d/abbrev_defs")
(setq save-abbrevs t)

(use-package auto-complete ;; Auto complete 
  :diminish auto-complete-mode
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))

(use-package yasnippet
  :diminish yas-global-mode
  :config
  (yas-global-mode 1)
  )

;;;; GIT AND MAGIT

(use-package magit)

;;;; Org Mode


;;;; OTHER PACKAGES

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (auto-complete rust-mode yasnippet-snippets yasnippet org nov magit diminish evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "GOOG" :family "Inconsolata for Powerline")))))
