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

(set-fringe-mode '(0 . 0))
;; (set-fringe-mode '(5 . 10))

(add-hook 'plain-TeX-mode-hook 'LaTeX-mode)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'latex-mode-hook  #'display-line-numbers-mode)
(add-hook 'LaTeX-mode-hook  #'display-line-numbers-mode)
(global-set-key (kbd "C-x C-l") 'display-line-numbers)

(setq tab-bar-close-button-show nil)
(setq tab-bar-new-button-show nil)
(global-hl-line-mode t)

;; (add-hook 'prog-mode-hook
;;         (lambda () (local-set-key (kbd "C-c C-c") #'recompile)))

(global-set-key (kbd "M-o") 'other-window)

(add-hook 'ibuffer-mode-hook
	  (lambda()
	    (local-unset-key (kbd "M-o"))
	    (global-set-key (kbd "M-o") 'other-window)))

(add-hook 'diff-mode-hook
	  (lambda()
	    (local-unset-key (kbd "M-o"))
	    (global-set-key (kbd "M-o") 'other-window)))

(defun myprevious-window ()
  (interactive)
  (other-window -1))
(global-set-key (kbd "M-O") 'myprevious-window)
(repeat-mode)
(setq delete-by-moving-to-trash t)
(setq dired-dwim-target t)
(setq dired-listing-switches "-al --group-directories-first")
(setq scroll-conservatively 101)
(setq scroll-margin 4)
(setq gc-cons-threshold 100000000)
(winner-mode)
(setq window-min-width 100)
(setq window-min-height 10)
(defalias 'yes-or-no-p 'y-or-n-p)

(pixel-scroll-precision-mode)
(setq ring-bell-function 'ignore)
(setq display-line-numbers-grow-only t)
;; (add-hook 'after-make-frame-functions #'ibuffer)
;; (display-battery-mode t)
(delete-selection-mode 1)
(savehist-mode)
;; (setq-default show-trailing-whitespace t)
(recentf-mode 1)
(setq eldoc-echo-area-use-multiline-p nil)
(setq ediff-window-setup-function #'ediff-setup-windows-plain)
(setq ediff-split-window-function #'split-window-horizontally)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-c C-g") 'global-whitespace-mode)

(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 200))

(defun my-inhibit-startup-screen-always ()
  "Startup screen inhibitor for `command-line-functions`.
	    Inhibits startup screen on the first unrecognised option."
  (ignore (setq inhibit-startup-screen t)))

(add-hook 'command-line-functions #'my-inhibit-startup-screen-always)

(setq isearch-lazy-count t)
(setq lazy-count-prefix-format "(%s/%s) ")
(setq lazy-count-suffix-format nil)
;;(setq search-whitespace-regexp ".*?")

(setq set-mark-command-repeat-pop t)

(global-set-key (kbd "M-;") 'comment-region)
(global-set-key (kbd "M-k") 'bury-buffer)
(global-set-key (kbd "M-K") 'kill-this-buffer)
(global-set-key (kbd "C-c o") 'ff-find-other-file)

(add-hook 'eshell-mode-hook (lambda () (setenv "TERM" "xterm")))

(setq compile-command "make -j $(nproc)")

(global-set-key (kbd "C-x p C-s") 'vc-git-grep)
(global-set-key (kbd "C-x p M-s") 'consult-git-grep)

(global-set-key (kbd "C-M-i") 'company-complete)
(setq-default mode-line-end-spaces nil)

;;(custom-set-faces
;; '(default ((t (:family "Inconsolata SemiCondensed" :foundry "CYRE" :slant normal :weight medium :height 90 :width semi-condensed)))))

;;(custom-set-faces
;; '(default ((t (:family "Hack" :foundry "SRC" :slant normal :weight regular :height 68 :width normal)))))


(custom-set-faces
 '(default ((t (:family "Cascadia Code" :foundry "SAJA" :slant normal :weight semi-light :height 68 :width normal)))))

(custom-set-faces
 '(variable-pitch ((t (:font "Ubuntu-9")))))

;; (custom-set-faces
;;  '(default ((t (:family "Iosevka Comfy" :foundry "UKWN" :slant normal :weight regular :height 75 :width normal)))))


    ;; (defun my-font-config (frame) (progn
    ;; 				(set-face-attribute 'fixed-pitch nil :font "Iosevka Comfy-9")
    ;; 				(set-face-attribute 'variable-pitch nil :font "Ubuntu-9")
    ;; 				(set-face-attribute 'default nil :font "Iosevka Comfy-9")))
  ;;   (defun my-font-config (frame) (progn
  ;; 				  (set-face-attribute 'fixed-pitch nil :font "Cascadia Code PL-8")
  ;; 				  (set-face-attribute 'variable-pitch nil :font "Ubuntu-9")
  ;; 				  (set-face-attribute 'default nil :font "Cascadia Code PL-8")))

  ;; (my-font-config nil)

  ;;   (if (daemonp)
  ;;       (add-hook 'after-make-frame-functions #'my-font-config)
  ;;     (my-font-config nil))

    ;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
    ;; (setq highlight-indent-guides-method 'character)
    (savehist-mode 1)

    (subword-mode)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
;; (use-package irony
;;   :ensure t
;;   :config
;;   (add-hook 'c++-mode-hook 'irony-mode)
;;   (add-hook 'c-mode-hook 'irony-mode))

(use-package opencl-mode
  :ensure t)
(add-to-list 'auto-mode-alist '("\\.cl\\'" . opencl-mode))

(setq vc-follow-symlinks t)

(use-package magit
  :ensure t
  :config (require 'magit-extras))

(use-package julia-mode
  :ensure t)

(use-package julia-repl
  :ensure t
  :config (add-to-list 'load-path "/usr/bin/julia")
  :hook (julia-mode . julia-repl-mode))

(when (display-graphic-p)
  (use-package all-the-icons
    :ensure t
    :config (setq all-the-icons-scale-factor 0.8)
	    (setq all-the-icons-fileicon-scale-factor 0.8)))

(when (display-graphic-p)
      (use-package all-the-icons-ibuffer
	:ensure t
	:hook (ibuffer-mode . all-the-icons-ibuffer-mode))

      (use-package all-the-icons-dired
	:ensure t
	:config (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

      (use-package all-the-icons-completion
	:ensure t
	:config (add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup)))

(when (display-graphic-p)
  (use-package doom-modeline
    :ensure t
    :config (doom-modeline-mode 1)
    :config (setq doom-modeline-height 16)
    ;; :config (setq doom-modeline-icon nil)
    (setq doom-modeline-buffer-file-name-style 'relative-from-project)))

(use-package company
    :ensure t
    :init
    (global-company-mode))

(use-package company-quickhelp
  :ensure t)

(add-hook 'company-search-mode
    (lambda ()
	(define-key company-mode-map (kbd "C-h C-h") 'company-complete-quick-access)))

;; (use-package corfu
;;   :ensure t
;;   ;; Optional customizations
;;   :custom
;;   ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
;;   (corfu-auto t)                 ;; Enable auto completion
;;   ;; (corfu-separator ?\s)          ;; Orderless field separator
;;   ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
;;   ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
;;   ;; (corfu-preview-current nil)    ;; Disable current candidate preview
;;   ;; (corfu-preselect-first nil)    ;; Disable candidate preselection
;;   ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
;;   ;; (corfu-echo-documentation nil) ;; Disable documentation in the echo area
;;   ;; (corfu-scroll-margin 5)        ;; Use scroll margin
;;   :bind
;;   ;; Configure SPC for separator insertion
;;   (:map corfu-map ("SPC" . corfu-insert-separator)
;; 	("M-p" . corfu-doc-scroll-down)
;; 	("M-n" . corfu-doc-scroll-up)
;; 	("M-d" . corfu-doc-toggle))
;;   ;; Enable Corfu only for certain modes.
;;   ;; :hook ((prog-mode . corfu-mode)
;;   ;;        (shell-mode . corfu-mode)
;;   ;;        (eshell-mode . corfu-mode))

;;   ;; Recommended: Enable Corfu globally.
;;   ;; This is recommended since Dabbrev can be used globally (M-/).
;;   ;; See also `corfu-excluded-modes'.
;;   :config
;;   (global-corfu-mode))
;; ;; (use-package kind-icon
;; ;;   :ensure t
;; ;;   :after corfu
;; ;;   :custom
;; ;;   (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
;; ;;   :config
;; ;;   (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("M-:" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :config

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
  :ensure t
  :config (vertico-mode)
	  (setq vertico-cycle t))

(use-package marginalia
  :ensure t
  :bind (("M-A" . marginalia-cycle)
	 :map minibuffer-local-map
	 ("M-A" . marginalia-cycle))
  :config
  (setq marginalia-max-relative-age 0)
  (setq marginalia-align 'center)
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
    (setq org-format-latex-options (plist-put org-format-latex-options :scale 0.18))
    :bind ("C-c l" . org-store-link)
    ("C-c a" . org-agenda)
    ("C-c c" . org-capture))

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (julia . t)))

(setq org-preview-latex-default-process 'dvisvgm)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 0.18))
(plist-put org-format-latex-options :background "Transparent")

(defun my/text-scale-adjust-latex-previews ()
  "Adjust the size of latex preview fragments when changing the
buffer's text scale."
  (pcase major-mode
    ('latex-mode
     (dolist (ov (overlays-in (point-min) (point-max)))
       (if (eq (overlay-get ov 'category)
               'preview-overlay)
           (my/text-scale--resize-fragment ov))))
    ('org-mode
     (dolist (ov (overlays-in (point-min) (point-max)))
       (if (eq (overlay-get ov 'org-overlay-type)
               'org-latex-overlay)
           (my/text-scale--resize-fragment ov))))))

(defun my/text-scale--resize-fragment (ov)
  (overlay-put
   ov 'display
   (cons 'image
         (plist-put
          (cdr (overlay-get ov 'display))
          :scale (+ 1.0 (* 0.25 text-scale-mode-amount))))))

(add-hook 'text-scale-mode-hook #'my/text-scale-adjust-latex-previews)

(use-package htmlize
  :ensure t)

(use-package elfeed
  :ensure t
  :config (setq elfeed-show-entry-switch 'display-buffer))

(custom-set-variables
 '(elfeed-feeds
   '("https://karthinks.com/index.xml" "https://www.brendangregg.com/blog/rss.xml" "https://quuxplusone.github.io/blog/feed.xml" "https://protesilaos.com/codelog.xml" "https://awesomekling.github.io/feed.xml" "https://andrewkelley.me/rss.xml" "https://floooh.github.io/feed.xml")))

(use-package doom-themes
     :ensure t)

   ;; (load-theme 'ef-light)

   ;; (custom-theme-set-faces
   ;;  'ef-light
   ;;  '(mode-line-active ((t (:inherit mode-line :box (:line-width (1 . 1) :color "#065fff" :style flat-button)))))
   ;;  '(mode-line-inactive ((t (:background "#dbdbdb" :foreground "#70627f" :box (:line-width (1 . 1) :color "#dbdbdb" :style flat-button)))))
   ;;  '(doom-modeline-bar-inactive ((t (:background "#dbdbdb"))))
   ;;  '(doom-modeline-bar ((t (:background "#b7c7ff")))))
   ;; ;; (load-theme 'ef-light)

   ;; (enable-theme 'ef-light)

   (load-theme 'doom-ir-black)
(custom-theme-set-faces
 'doom-ir-black
 '(doom-modeline-bar-inactive ((t (:background "grey6"))))
 '(font-lock-comment-face ((t (:foreground "#cf9f8f" :slant oblique))))
 ;; '(font-lock-doc-face ((t (:foreground "#cdf25e" :slant oblique))))
 ;; '(font-lock-doc-face ((t (:foreground "#98d9fa" :slant oblique))))
 '(font-lock-doc-face ((t (:foreground "#96cbfe" :slant oblique))))
 ;; '(font-lock-comment-face ((t (:foreground "grey60" :slant oblique))))
 '(font-lock-function-name-face ((t (:foreground "#d0b9f0"))))
 '(doom-modeline-bar ((t (:background "grey15"))))
 '(doom-modeline-persp-name ((t (:foreground "#99CC99" :slant normal))))
 '(doom-modeline-persp-buffer-not-in-persp ((t (:foreground "#83898d" :slant normal))))
 '(mode-line ((t (:background "grey15" :foreground "#ffffff" :box nil))))
 '(mode-line-inactive ((t (:background "gray6" :foreground "#5B6268" :box nil))))
 ;; '(line-number-current-line ((t (:foreground "white" :background "grey6"))))
 ;; '(line-number ((t (:foreground "#5B6268" :background "grey6"))))
 '(line-number-current-line ((t (:foreground "white" :background "#121212" :weight bold))))
 '(line-number ((t (:foreground "#5B6268"))))
 '(org-block ((t (:extend t :background "grey5"))))
 ;; '(font-lock-type-face ((t (:foreground "#FFFFB6" :slant oblique))))
 '(font-lock-type-face ((t (:foreground "#FFFFB6"))))
 '(diff-removed ((t (:background "#2b0000" :foreground "#cc564c"))))
 '(diff-added ((t (:background "#1d2e10" :foreground "#A8FF60"))))
 '(diff-refine-added ((t (:foreground "#A8FF60" :background "#213313" :weight bold))))
 '(diff-refine-removed ((t (:foreground "#ff6c60" :background "#4f3438" :weight bold))))
 '(diff-hl-dired-ignored ((t (:foreground "#5B6268" :background "#5B6268"))))
 '(diff-hl-dired-unknown ((t (:foreground "#a9a1e1" :background "#a9a1e1"))))
 '(diff-hunk-header ((t (:foreground "#a9a1e1" :background "#1e1c29"))))
 '(ediff-current-diff-A ((t (:background "#4f3438" :foreground "#ff6c60"))))
 '(ediff-current-diff-B ((t (:background "#213313" :foreground "#A8FF60"))))
 '(ediff-fine-diff-A ((t (:background "#572d33" :foreground "#ff6c60"))))
 '(ediff-fine-diff-B ((t (:background "#26450e" :foreground "#A8FF60"))))
 '(dired-directory ((t (:foreground "coral" :weight bold))))
 '(font-lock-builtin-face ((t (:foreground "wheat2"))))
 '(outline-2 ((t (:foreground "coral"))))
 '(outline-3 ((t (:foreground "#99CC99"))))
 '(outline-4 ((t (:foreground "wheat2"))))
 '(font-lock-keyword-face ((t (:foreground "#96cbfe" :weight bold))))
 '(font-lock-preprocessor-face ((t (:foreground "#ffabfb" :weight bold))))
 '(Man-overstrike ((t (:foreground "#96cbfe" :weight bold))))
 '(Man-underline ((t (:foreground "wheat2" :underline t))))
 '(pulsar-cyan ((t (:background "#96cbfe"))))
 '(ansi-color-bright-black ((t (:background "grey60" :foreground "grey60"))))
 '(fixed-pitch ((t ())))
 '(mode-line-active ((t (:inherit mode-line :box (:line-width (1 . 1) :color "grey34" :style flat-button)))))
 '(mode-line-inactive ((t (:background "gray6" :foreground "#5B6268" :box (:line-width (1 . 1) :color "gray6" :style flat-button)))))
 '(isearch ((t (:background "#fac200" :foreground "#000000"))))
 ;; '(font-lock-preprocessor-face ((t (:foreground "coral"))))
 '(font-lock-string-face ((t (:foreground "SkyBlue1"))))
 '(font-lock-variable-name-face ((t (:foreground "aquamarine3"))))
 '(company-tooltip-selection ((t (:background "grey21" :foreground "SkyBlue1" :weight bold))))
 '(company-tooltip-scrollbar-track ((t (:background "grey15"))))
 '(font-lock-builtin-face ((t (:foreground "pink1"))))
 '(ansi-color-magenta ((t (:foreground "#a9a1e1" :background "#a9a1e1"))))
 '(ansi-color-bright-magenta ((t (:foreground "#ffabfb" :background "#ffabfb"))))
 '(ansi-color-blue ((t (:foreground "#96cbfe" :background "#96cbfe"))))
 '(ansi-color-bright-blue ((t (:foreground "#96cbfe" :background "#96cbfe"))))
 '(ansi-color-green ((t (:foreground "#99CC99" :background "#99CC99"))))
 '(ansi-color-bright-green ((t (:foreground "#A8FF60" :background "#A8FF60"))))
 '(ansi-color-yellow ((t (:foreground "wheat2" :background "wheat2"))))
 '(ansi-color-bright-yellow ((t (:foreground "wheat2" :background "wheat2"))))
 '(ansi-color-red ((t (:foreground "#ff6c60" :background "#ff6c60"))))
 '(ansi-color-bright-red ((t (:foreground "#cc564c" :background "#cc564c"))))
 '(ansi-color-cyan ((t (:foreground "#a9a1e1" :background "#a9a1e1"))))
 '(ansi-color-bright-cyan ((t (:foreground "#a9a1e1" :background "#a9a1e1")))))

   (enable-theme 'doom-ir-black)

(use-package autothemer
  :ensure t)

(use-package cape
  :ensure t
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  :bind (
	 ("M-/" . cape-dabbrev))
  :config
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-history)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-tex)
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
	 ;; ("C-x C-b" . consult-buffer-other-window)
	 ("C-x p b" . consult-project-buffer)
	 ("C-c s" . consult-imenu-multi)
	 ("M-y" . consult-yank-pop)
	 ("M-s" . consult-line))

(use-package diff-at-point
  :ensure t)

;; (use-package diff-hl
;;   :ensure t
;;   :config
;;   (require 'diff-hl)
;;   (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
;;   (global-diff-hl-mode))

(defun my-fringe-hook ()
  (setq left-fringe-width 0
	right-fringe-width 0))

(add-hook 'prog-mode-hook 'my-fringe-hook)
(add-hook 'org-mode-hook 'my-fringe-hook)
(add-hook 'dired-mode-hook 'my-fringe-hook)
(add-hook 'Man-mode-hook 'my-fringe-hook)

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(setq dired-listing-switches "-alh --group-directories-first")
(add-hook 'dired-mode-hook 'dired-omit-mode)

;; (use-package dired-git-info
;;   :ensure t
;;   :config (add-hook 'dired-after-readin-hook 'dired-git-info-auto-enable))

;; (use-package eglot-jl
;;   :ensure t)

;; (defun my-julia-init ()
;;   (progn
;;     (eglot-jl-init)
;;     (eglot-ensure)))

(defun my-zig-init ()
  (progn
    (eglot-ensure)))

(use-package eglot
  :ensure t
  :config
  (add-to-list 'eglot-server-programs '((c++-mode c-mode) . ("clangd"
							     "--header-insertion=never")))
  (add-to-list 'eglot-server-programs '(zig-mode . ("zls")))
  (add-hook 'python-mode 'eglot-ensure)
  (add-hook 'c-mode-hook 'eglot-ensure)
  (add-hook 'c++-mode-hook 'eglot-ensure)
  ;; (add-hook 'julia-mode-hook 'my-julia-init)
  (add-hook 'zig-mode-hook 'my-zig-init)
  (setq eglot-connect-timeout 10000))

(use-package exec-path-from-shell
  :ensure t)

(when (daemonp)
  (exec-path-from-shell-initialize))

(exec-path-from-shell-initialize)

(use-package fancy-compilation
  :ensure t
  :config (fancy-compilation-mode)
  (setq fancy-compilation-term "xterm")
  ;; (setq fancy-compilation-override-colors nil)
  )

(use-package page-break-lines
  :ensure t
  :config (global-page-break-lines-mode))

;; (if (daemonp)
;;     (use-package persp-mode
;;       :ensure t
;;       :init (persp-mode)
;;       (setq persp-add-buffer-on-after-change-major-mode t)
;;       (setq persp-auto-save-opt 0)
;;       (global-set-key (kbd "C-x b") #'(lambda (arg)
;; 					(interactive "P")
;; 					(with-persp-buffer-list () (consult-buffer arg))))
;;       (global-set-key (kbd "C-x C-b") #'(lambda (arg)
;; 					  (interactive "P")
;; 					  (with-persp-buffer-list () (ibuffer arg))))))

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
  :config
  (setq popper-reference-buffers
	'("\\*Async Shell Command\\*"
	  "\\*julia\\*"
	  "\\*vterm\\*"
	  "\\*eldoc\\*"
	  "\\*Shell Command Output\\*"
	  "\\*Async Shell Command Output\\*"
	  ;; Man-mode
	  help-mode
	  eshell-mode
	  compilation-mode
	  pdf-outline-buffer-mode))
  (popper-mode +1)
  (popper-echo-mode +1)
  (setq popper-group-function #'popper-group-by-project)
  :custom (popper-mode-line nil))

(use-package pulsar
  :ensure t
  :config ;; (pulsar-global-mode 1)
	  ;; (setq pulsar-pulse nil)
	  (setq pulsar-face 'pulsar-red)
	  (setq pulsar-delay 0.05)
	  (add-hook 'next-error-hook #'pulsar-pulse-line)
  :custom (pulsar-pulse-functions '(;; other-window
				    occur-mode-goto-occurrence
				    ;; windmove-do-window-select
				    ;; mouse-set-point
				    ;; mouse-select-window
				    ;; scroll-up-command
				    ;; scroll-down-command
				    ;; recenter-top-bottom
				    isearch-repeat-forward
				    isearch-repeat-backward
				    ;; beginning-of-buffer
				    ;; end-of-buffer
				    )))

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

(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key (kbd "M-p") 'move-line-up)
(global-set-key (kbd "M-n") 'move-line-down)

(use-package xclip
  :ensure t
  :config (xclip-mode t))

(use-package gnugo
  :ensure t
  :config
  (setq gnugo-xpms 'gnugo-imgen-create-xpms)
  (setq gnugo-imgen-style 'ttn))
(put 'dired-find-alternate-file 'disabled nil)
