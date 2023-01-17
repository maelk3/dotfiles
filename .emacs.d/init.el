(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

(setq custom-file "~/.emacs.d/custom.el") ;; set custom file to ~/.emacs.d/custom.el
(load custom-file)                        ;; load the custom file

(tool-bar-mode -1)
(menu-bar-mode -1)
(customize-set-variable 'scroll-bar-mode nil)
(customize-set-variable 'horizontal-scroll-bar-mode nil)

(xterm-mouse-mode 1)                     ;; enable mouse

(set-face-inverse-video-p 'vertical-border nil)
(set-face-background 'vertical-border (face-background 'default))
(set-display-table-slot standard-display-table 'vertical-border (make-glyph-code ?┃))

(setq tex-fontify-script nil)
(setq font-latex-fontify-script nil)

(set-fringe-mode '(1 . 1))

(add-hook 'plain-TeX-mode-hook 'LaTeX-mode)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'latex-mode-hook  #'display-line-numbers-mode)
(global-set-key (kbd "C-x C-l") 'display-line-numbers)

(setq tab-bar-close-button-show nil)
(setq tab-bar-new-button-show nil)
(global-hl-line-mode t)

(add-hook 'prog-mode-hook
        (lambda () (local-set-key (kbd "C-c C-c") #'recompile)))

(global-set-key (kbd "M-o") 'other-window)
(repeat-mode)
(setq delete-by-moving-to-trash t)
(setq dired-listing-switches "-al --group-directories-first")
(setq scroll-conservatively 101)
(setq scroll-margin 4)
(setq gc-cons-threshold 100000000)
(winner-mode)
(setq window-min-width 50)
(setq window-min-height 10)
(defalias 'yes-or-no-p 'y-or-n-p)

(defun my-font-config (frame) (progn
				(set-face-attribute 'variable-pitch nil :font "Source Sans Pro-12")
				(set-face-attribute 'fixed-pitch nil :font "PragmataPro Mono Liga-12")
				(set-face-attribute 'default nil :font "PragmataPro Mono Liga-12")))

(if (daemonp)
    (add-hook 'after-make-frame-functions #'my-font-config)
  (my-font-config nil))

;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;; (setq highlight-indent-guides-method 'character)
(savehist-mode 1)

;; (use-package irony
;;   :ensure t
;;   :config
;;   (add-hook 'c++-mode-hook 'irony-mode)
;;   (add-hook 'c-mode-hook 'irony-mode))

(setq vc-follow-symlinks t)

(require 'magit)
(require 'magit-extras)

(use-package julia-mode
  :ensure t)

(use-package julia-repl
  :ensure t
  :config (add-to-list 'load-path "/usr/bin/julia")
  :hook (julia-mode . julia-repl-mode))

(use-package all-the-icons
  :config (setq all-the-icons-scale-factor 1.0)
          (setq all-the-icons-fileicon-scale-factor 1.0))

(use-package all-the-icons-ibuffer
  :ensure t
  :hook (ibuffer-mode . all-the-icons-ibuffer-mode))

(use-package all-the-icons-dired
  :ensure t
  :init (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

(use-package all-the-icons-completion
  :ensure t
  :init (add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup))

;; (use-package doom-modeline
;;   :ensure t
;;   :config (doom-modeline-mode 1)
;;   (setq doom-modeline-height 30)
;;   (setq doom-modeline-buffer-file-name-style 'relative-from-project))

(use-package corfu
  :ensure t
  ;; Optional customizations
  :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect-first nil)    ;; Disable candidate preselection
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-echo-documentation nil) ;; Disable documentation in the echo area
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin
  :bind
  ;; Configure SPC for separator insertion
  (:map corfu-map ("SPC" . corfu-insert-separator)
	("M-p" . corfu-doc-scroll-down)
	("M-n" . corfu-doc-scroll-up)
	("M-d" . corfu-doc-toggle))
  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since Dabbrev can be used globally (M-/).
  ;; See also `corfu-excluded-modes'.
  :init
  (global-corfu-mode)
  (corfu-doc-mode))
;; (use-package kind-icon
;;   :ensure t
;;   :after corfu
;;   :custom
;;   (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
;;   :config
;;   (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package embark
  :ensure t

  :bind
  (("C-;" . embark-act)         ;; pick some comfortable binding
   ("M-:" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command))


;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t
  :after (embark consult)
  :demand t ; only necessary if you have the hook below
  ;; if you want to have consult previews as you move around an
  ;; auto-updating embark collect buffer
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package vertico
  :config (vertico-mode)
          (setq vertico-cycle t))

(use-package marginalia
  :bind (("M-A" . marginalia-cycle)
	 :map minibuffer-local-map
	 ("M-A" . marginalia-cycle))
  :init (marginalia-mode))

(use-package orderless
           :ensure t
           :custom
           ((completion-styles '(orderless basic))
           (completion-category-overrides '((file (styles basic partial-completion))))))

(use-package org-bullets
  :after (org)
  :ensure t)

(use-package org
  :ensure t
  :hook (org-mode . org-bullets-mode)
  :config (setq org-agenda-files '("~/org/"))
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-ellipsis " ")
  (setq org-src-fontify-natively t)
  (setq org-highlight-latex-and-related '(latex script entities))
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))
  :bind ("C-c l" . org-store-link)
  ("C-c a" . org-agenda)
  ("C-c c" . org-capture))

;; (if (daemonp)
;;     (setq initial-major-mode 'org-mode))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (julia . t)))

(use-package htmlize
  :ensure t)

(use-package elfeed
  :ensure t
  :init (setq elfeed-show-entry-switch 'display-buffer))

(use-package doom-themes
  :ensure t)

;; (setq custom--inhibit-theme-enable nil)
(load-theme 'doom-ir-black)

(custom-theme-set-faces
 'doom-ir-black
 '(doom-modeline-bar-inactive ((t (:background "grey6"))))     
 '(mode-line ((t (:background "grey15" :foreground "#ffffff" :box nil))))
 '(mode-line-inactive ((t (:background "gray6" :foreground "#5B6268" :box nil))))
 '(line-number-current-line ((t (:inherit (hl-line default) :foreground "white" :slant italic :weight bold))))
 '(org-block ((t (:extend t :background "grey5"))))
 '(diff-removed ((t (:background "#121212"))))
 '(diff-refine-added ((t (:foreground "#A8FF60" :background "#213313" :weight bold))))
 '(diff-refine-removed ((t (:foreground "#ff6c60ww" :background "#4f3438" :weight bold))))
 '(diff-hl-dired-ignored ((t (:foreground "#5B6268" :background "#5B6268"))))
 '(diff-hl-dired-unknown ((t (:foreground "#a9a1e1" :background "#a9a1e1"))))     
 '(dired-directory ((t (:foreground "coral" :weight bold))))
 '(font-lock-builtin-face ((t (:foreground "wheat2"))))
 '(outline-2 ((t (:foreground "coral"))))
 '(outline-3 ((t (:foreground "#99CC99"))))
 '(outline-4 ((t (:foreground "wheat2"))))
 '(font-lock-keyword-face ((t (:foreground "#96cbfe" :weight bold))))
 '(font-lock-preprocessor-face ((t (:foreground "#ffabfb" :weight bold))))
 '(Man-overstrike ((t (:foreground "#96cbfe" :weight bold))))
 '(Man-underline ((t (:foreground "wheat2" :underline t)))))

(enable-theme 'doom-ir-black)

(use-package autothemer
  :ensure t)

(use-package cape
  :ensure t
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  :bind (
	 ("M-/" . cape-dabbrev))
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  ;;(add-to-list 'completion-at-point-functions #'cape-history)
  ;;(add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-tex)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;;(add-to-list 'completion-at-point-functions #'cape-ispell)
  ;;(add-to-list 'completion-at-point-functions #'cape-dict)
  ;;(add-to-list 'completion-at-point-functions #'cape-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
  )

(use-package consult
  :ensure t
  :bind ("C-x b" . consult-buffer)
	 ("C-x C-b" . consult-buffer-other-window)
	 ("C-x p b" . consult-project-buffer)
	 ("C-c s" . consult-imenu-multi)
	 ("M-y" . consult-yank-pop)
	 ("M-s" . consult-line)
	 ("C-c o" . consult-file-externally))

(use-package diff-at-point
  :ensure t)

(require 'diff-hl)
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)
(global-diff-hl-mode)

(defun my-fringe-hook ()
  (setq left-fringe-width 4
	right-fringe-width 10))

  (add-hook 'prog-mode-hook 'my-fringe-hook)
  (add-hook 'org-mode-hook 'my-fringe-hook)
  (add-hook 'dired-mode-hook 'my-fringe-hook)

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(setq dired-listing-switches "-alh --group-directories-first")
(add-hook 'dired-mode-hook 'dired-omit-mode)

(use-package eglot-jl
  :ensure t)

(defun my-julia-init ()
  (progn
    (eglot-jl-init)
    (eglot-ensure)))

(use-package eglot
  :ensure t
  :config
  (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
  (add-hook 'c-mode-hook 'eglot-ensure)
  (add-hook 'c++-mode-hook 'eglot-ensure)
  (add-hook 'julia-mode-hook 'my-julia-init)
  (setq eglot-connect-timeout 10000))

(use-package pdf-tools
  :ensure t
  ;; :hook (pdf-tools-enabled . pdf-view-midnight-minor-mode)
  :config (setq pdf-view-midnight-colors '("white" . "black")))

(if (daemonp)
    (pdf-tools-install))

(use-package popper
  :ensure t
  :bind (("C-S-p"   . popper-toggle-latest)
	 ("C-S-z"   . popper-cycle)
	 ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
	'("\\*Async Shell Command\\*"
	  ;; "\\*elfeed-search\\*"
	  "\\*julia\\*"
	  "\\*vterm\\*"
	  "\\*eldoc\\*"
	  eldoc-mode
	  help-mode
	  compilation-mode
	  pdf-outline-buffer-mode))
  (popper-mode +1)
  (popper-echo-mode +1)
  :custom (popper-mode-line nil))

(use-package pulsar
  :ensure t
  :init (pulsar-global-mode 1)
  :custom (pulsar-pulse-functions '(other-window
				    windmove-do-window-select
				    mouse-set-point
				    mouse-select-window
				    scroll-up-command
				    scroll-down-command
				    recenter-top-bottom
				    isearch-repeat-forward
				    isearch-repeat-backward
				    beginning-of-buffer
				    end-of-buffer)))

(use-package vterm
  :ensure t
  :bind ("M-T" . vterm))

(use-package rainbow-mode
  :ensure t)

(use-package transpose-frame
  :ensure t)

(defun my/windmove-right ()
    "change focus to the window on the right it is exists, otherwise change focus to the left"
    (interactive)
    (cond
     ((window-in-direction 'right) (windmove-right))
     ((window-in-direction 'left)  (windmove-left))))

  (defun my/windmove-left ()
    "change focus to the window on the left it is exists, otherwise change focus to the right"
    (interactive)
    (cond
     ((window-in-direction 'left) (windmove-left))
     ((window-in-direction 'right)  (windmove-right))))

  (defun my/windmove-up ()
    "change focus to the window above it is exists, otherwise change focus to the window below"
    (interactive)
    (cond
     ((window-in-direction 'above) (windmove-up))
     ((window-in-direction 'below)  (windmove-down))))

  (defun my/windmove-down ()
    "change focus to the window below it is exists, otherwise change focus to the window above"
    (interactive)
    (cond
     ((window-in-direction 'below) (windmove-down))
     ((window-in-direction 'above)  (windmove-up))))


  ;; unbind clone buffer in info mode and bind windmove down
  (add-hook 'Info-mode-hook (lambda () (progn (local-unset-key (kbd "M-n"))
					      (local-set-key (kbd "M-n") 'my/windmove-down))))

;;   (global-set-key (kbd "M-n") 'my/windmove-down)
;;   (global-set-key (kbd "M-p") 'my/windmove-up)
;;   (global-set-key (kbd "M-f") 'my/windmove-right)
;;   (global-set-key (kbd "M-b") 'my/windmove-left)

  (global-set-key (kbd "M-N") 'flip-frame)
  (global-set-key (kbd "M-P") 'flip-frame)
  (global-set-key (kbd "M-F") 'flop-frame)
  (global-set-key (kbd "M-B") 'flop-frame)
  (global-set-key (kbd "M-R") 'transpose-frame)

(use-package xclip
  :ensure t
  :config (xclip-mode t))

(use-package gnugo
  :ensure t
  :config
  (setq gnugo-xpms 'gnugo-imgen-create-xpms)
  (setq gnugo-imgen-style 'ttn))
(put 'dired-find-alternate-file 'disabled nil)
