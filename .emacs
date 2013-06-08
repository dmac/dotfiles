(if (display-graphic-p) (menu-bar-mode 1) (menu-bar-mode -1))
(when (boundp 'tool-bar-mode) (tool-bar-mode -1))
(when (boundp 'scroll-bar-mode) (scroll-bar-mode -1))

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(ac-nrepl
                      auto-complete
                      base16-theme
                      clojure-mode
                      clojure-test-mode
                      color-theme
                      evil
                      evil-leader
                      evil-nerd-commenter
                      evil-paredit
                      fiplr
                      flycheck
                      ido-ubiquitous
                      ido-vertical-mode
                      magit
                      markdown-mode
                      midje-mode
                      nrepl
                      paredit
                      paredit-menu
                      rainbow-delimiters
                      slime
                      smart-tab
                      smex
                      surround
                      undo-tree
                      yasnippet))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(setq custom-file (expand-file-name "~/.emacs.d/custom.el"))
(load custom-file t)

(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq ring-bell-function 'ignore)
(setq mac-option-modifier 'alt)
(setq mac-command-modifier 'meta)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq lazy-highlight-initial-delay 0)
(setq split-height-threshold 40)
(setq split-width-threshold 200)
(setq split-window-preferred-function 'split-window-sensibly-reverse)
(setq vc-follow-symlinks t)

(global-font-lock-mode t)
(global-auto-revert-mode t)
(global-hl-line-mode t)
(global-linum-mode t)
(line-number-mode 1)
(column-number-mode 1)

(eval-after-load 'paren
  '(setq show-paren-delay 0))
(show-paren-mode t)

(set-face-attribute 'default nil :font "Inconsolata\ Bold-14")

(global-set-key (kbd "RET") 'comment-indent-new-line)
(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-j") 'windmove-down)
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-l") 'windmove-right)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(global-undo-tree-mode t)

(global-whitespace-mode t)
(eval-after-load 'whitespace
  '(progn
     (setq whitespace-line-column 110)
     (setq whitespace-style '(face empty trailing tabs tab-mark lines-tail))))
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq-default tab-width 2)
(setq-default evil-shift-width 2)

;; No tabs by default. Modes that really need tabs should enable indent-tabs-mode explicitly.
;; Makefile-mode already does that, for example.
;; If indent-tabs-mode is off, untabify before saving.
(setq-default indent-tabs-mode nil)
(add-hook 'write-file-hooks
          (lambda ()
            (if (not indent-tabs-mode)
                (untabify (point-min) (point-max)))
            nil))

(ido-mode t)
(ido-ubiquitous-mode t)
(ido-vertical-mode t)
(eval-after-load 'ido
  '(progn
     (setq ido-enable-flex-matching t)
     (setq ido-use-virtual-buffers t)
     (setq ido-everywhere t)))

;; Include path information in duplicate buffer names (e.g. a/foo.txt b/foo.txt)
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(require 'auto-complete)
(global-auto-complete-mode t)
(setq ac-auto-start nil)
(ac-set-trigger-key "TAB")
(ac-linum-workaround)

;; Automatic syntax checking
(global-flycheck-mode t)
(eval-after-load 'flycheck
  '(setq flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers)))

(require 'smart-tab)
(global-smart-tab-mode t)

;; Snippets
(yas-global-mode t)

(global-surround-mode t)
(global-rainbow-delimiters-mode t)

;; Evil

(evil-mode t)
(global-evil-leader-mode)

(evil-leader/set-key
  "ee" 'open-emacs-config
  "eb" 'eval-buffer
  "es" 'eval-last-sexp
  "ex" 'eval-expression
  "gs" 'magit-status
  "gl" 'magit-log
  "b" 'ido-switch-buffer
  "v" 'fiplr-find-file)

(evil-leader/set-key-for-mode 'clojure-mode
  "eb" 'nrepl-load-current-buffer
  "es" 'nrepl-eval-last-expression)

(eval-after-load 'evil
  '(progn
     (setq evil-default-cursor t)
     (setq evil-leader/leader ",")
     ;; Unbind these keys in evil so they can instead be used for code navigation.
     (define-key evil-normal-state-map (kbd "M-,") nil)
     (define-key evil-normal-state-map (kbd "M-.") nil)))

(evilnc-default-hotkeys)

;; Fuzzy project file finding
(eval-after-load 'fiplr
  '(setq fiplr-ignored-globs '((directories (".git" ".svn" "target" "log"))
                               (files (".#*" "*.so" ".DS_Store")))))

(add-hook 'clojure-mode-hook 'clojure-test-mode)
(eval-after-load 'clojure-mode
  '(define-key clojure-mode-map "\C-c\M-r" 'nrepl-switch-to-repl-buffer))

;; Autocompletion in nrepl
(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load 'auto-complete '(add-to-list 'ac-modes 'nrepl-mode))

(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)

;; Count hyphens, etc. as word characters in lisps
(add-hook 'clojure-mode-hook (lambda () (modify-syntax-entry ?- "w")))
(add-hook 'emacs-lisp-mode-hook (lambda () (modify-syntax-entry ?- "w")))
(add-hook 'scheme-mode-hook (lambda () (modify-syntax-entry ?- "w")))
(add-hook 'scheme-mode-hook (lambda () (modify-syntax-entry ?> "w")))

(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rkt$" . scheme-mode))

(defun open-emacs-config ()
  (interactive)
  (find-file-other-window "~/.emacs"))

(defun split-window-sensibly-reverse (&optional window)
  "Identical to the built-in function split-window-sensibly, but prefers horizontal splits over vertical splits."
  (let ((window (or window (selected-window))))
    (or (and (window-splittable-p window t)
       ;; Split window horizontally.
       (with-selected-window window
         (split-window-right)))
  (and (window-splittable-p window)
       ;; Split window vertically.(column-marker-1 80)
       (with-selected-window window
         (split-window-below)))
  (and (eq window (frame-root-window (window-frame window)))
       (not (window-minibuffer-p window))
       ;; If WINDOW is the only window on its frame and is not the
       ;; minibuffer window, try to split it vertically disregarding
       ;; the value of `split-height-threshold'.
       (let ((split-height-threshold 0))
         (when (window-splittable-p window)
     (with-selected-window window
       (split-window-below))))))))

;; OS X keybindings minor mode
;; http://stackoverflow.com/questions/683425/globally-override-key-binding-in-emacs
(defvar osx-keys-minor-mode-map (make-keymap) "osx-keys-minor-mode-keymap")

(define-key osx-keys-minor-mode-map (kbd "M-`") 'other-frame)
(define-key osx-keys-minor-mode-map (kbd "M-w") 'delete-frame)
(define-key osx-keys-minor-mode-map (kbd "M-q") 'save-buffers-kill-terminal)
(define-key osx-keys-minor-mode-map (kbd "M-N") 'new-frame)
(define-key osx-keys-minor-mode-map (kbd "M-v") 'clipboard-yank)
(define-key osx-keys-minor-mode-map (kbd "M-c") 'clipboard-kill-ring-save)

(define-minor-mode osx-keys-minor-mode
  "A minor-mode for emulating osx keyboard shortcuts."
  t " osx" osx-keys-minor-mode-map)

(osx-keys-minor-mode t)

(defadvice load (after give-osx-keybindings-priority)
  "Try to ensure that osx keybindings always have priority."
  (if (not (eq (car (car minor-mode-map-alist)) 'osx-keys-minor-mode))
      (let ((osx-keys (assq 'osx-keys-minor-mode minor-mode-map-alist)))
        (assq-delete-all 'osx-keys-minor-mode minor-mode-map-alist)
        (add-to-list 'minor-mode-map-alist osx-keys))))
(ad-activate 'load)
