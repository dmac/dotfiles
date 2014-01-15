(if (display-graphic-p) (menu-bar-mode 1) (menu-bar-mode -1))
(when (and (fboundp 'tool-bar-mode) tool-bar-mode) (tool-bar-mode -1))
(when (and (fboundp 'scroll-bar-mode) scroll-bar-mode) (scroll-bar-mode -1))

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(ac-nrepl
                      ack-and-a-half
                      auto-complete
                      base16-theme
                      clojure-mode
                      clojure-test-mode
                      coffee-mode
                      color-theme
                      evil
                      evil-leader
                      evil-nerd-commenter
                      evil-paredit
                      flx-ido
                      flycheck
                      ghc
                      gitconfig-mode
                      go-mode
                      haskell-mode
                      ido-ubiquitous
                      ido-vertical-mode
                      magit
                      markdown-mode
                      midje-mode
                      mo-git-blame
                      nrepl
                      paredit
                      paredit-menu
                      projectile
                      rainbow-delimiters
                      ruby-electric
                      slime
                      smex
                      surround
                      undo-tree
                      yaml-mode
                      yasnippet))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(setq custom-file (expand-file-name "~/.emacs.d/custom.el"))
(load custom-file t)

(setq custom-safe-themes t)
(load-theme 'base16-default)

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
(setq-default require-final-newline t)
(setq scroll-step 1)                                ; keyboard scroll one line at a time
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ; mouse scroll one line at a time
(setq mouse-wheel-progressive-speed nil)            ; don't accelerate scrolling

(global-undo-tree-mode t)
(global-font-lock-mode t)
(global-auto-revert-mode t)
(global-hl-line-mode t)
(global-linum-mode t)
(global-visual-line-mode t)
(line-number-mode 1)
(column-number-mode 1)
(add-hook 'dired-mode (lambda ()
                        (message ">> reverting!")
                        (revert-buffer)))

(eval-after-load 'paren
  '(setq show-paren-delay 0))
(show-paren-mode t)

(set-face-attribute 'default nil :font "Inconsolata\ Bold-14")

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
(global-set-key (kbd "M--") 'text-scale-decrease)
(global-set-key (kbd "M-+") 'text-scale-increase)
(global-set-key (kbd "M-0") (lambda () (interactive) (text-scale-set 0)))

(global-surround-mode t)
(global-rainbow-delimiters-mode t)

;; Disable org-mode keybinding that interferes with custom window switching.
(eval-after-load 'org
  '(define-key org-mode-map (kbd "M-h") nil))

;; Whitespace settings
(global-whitespace-mode t)
(eval-after-load 'whitespace
  '(progn
     (setq whitespace-line-column 110)
     (setq whitespace-style '(face empty trailing tabs tab-mark))
     (add-hook 'prog-mode-hook
               (lambda () (set (make-local-variable 'whitespace-style)
                               '(face empty trailing tabs tab-mark lines-tail))))
     (add-hook 'go-mode-hook
               (lambda () (set (make-local-variable 'whitespace-style)
                               '(face empty trailing lines-tail))))))

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
     (setq ido-use-virtual-buffers t)
     (setq ido-use-faces nil)))

;; Better ido-mode completion
(flx-ido-mode t)
(eval-after-load 'flx-ido
  '(setq flx-ido-use-faces nil))

(projectile-global-mode)

;; Include path information in duplicate buffer names (e.g. a/foo.txt b/foo.txt)
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Autocompletion
(add-hook 'prog-mode-hook 'auto-complete-mode)
(eval-after-load 'auto-complete
  '(progn
     (define-key ac-complete-mode-map "\C-n" 'ac-next)
     (define-key ac-complete-mode-map "\C-p" 'ac-previous)
     (setq ac-auto-start nil)
     (ac-set-trigger-key "TAB")
     (ac-linum-workaround)))

;; Automatic syntax checking
(add-hook 'prog-mode-hook 'flycheck-mode)
(eval-after-load 'flycheck
  '(progn
    (define-key flycheck-mode-map (kbd "M-n") 'flycheck-next-error)
    (define-key flycheck-mode-map (kbd "M-p") 'flycheck-previous-error)
    (setq flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers))))

;; Snippets
(eval-after-load 'yasnippet
  '(progn
     (setq yas-snippet-dirs "~/.emacs.d/snippets") ; Only load my snippets
     (yas-reload-all)))
(add-hook 'prog-mode-hook 'yas-minor-mode)

;; Org mode

(eval-after-load 'org
  '(progn
     (setq org-hide-leading-stars t)
     (setq org-startup-indented t)
     (add-to-list 'org-agenda-files "~/org/notes.org")
     (setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
     (setq org-mobile-inbox-for-pull "~/org/notes.org")
     (setq org-default-notes-file "~/org/refile.org")
     (setq org-mobile-files '("notes.org"))
     ; Disable org-mode keybinding that interferes with custom window switching.
     (define-key org-mode-map (kbd "M-h") nil)))
     ;; TODO: Figure out how to make "o" insert new heading
     ;; also see org-M-RET-may-split-line
     ;; (define-key evil-normal-state-map (kbd "o") 'org-meta-return)))


;; Evil

(evil-mode t)
(global-evil-leader-mode)

(evil-leader/set-key
  "ee" 'open-emacs-config
  "ss" 'open-notes-org-mode
  "eb" 'eval-buffer
  "es" 'eval-last-sexp
  "ex" 'eval-expression
  "gs" 'magit-status
  "gl" 'magit-log
  "b" 'ido-switch-buffer
  "v" 'projectile-find-file)

(evil-leader/set-key-for-mode 'clojure-mode
  "eb" 'nrepl-load-current-buffer
  "es" 'nrepl-eval-last-expression)

(eval-after-load 'evil
  '(progn
     (setq evil-default-cursor t)
     (setq evil-leader/leader ",")
     ;; Unbind these keys in evil so they can instead be used for code navigation.
     (define-key evil-normal-state-map (kbd "M-,") nil)
     (define-key evil-normal-state-map (kbd "M-.") nil)
     ;; Navigate by visual lines instead of absolute lines
     (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
     (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
     (define-key evil-insert-state-map (kbd "RET") 'comment-indent-new-line)
     (define-key evil-insert-state-map (kbd "C-e") 'end-of-visual-line)))

;; TODO Disable some evil keys in mo-git-blame-mode
;; (add-hook 'mo-git-blame-mode 'e)

(evilnc-default-hotkeys)

;; Clojure
(add-hook 'clojure-mode-hook 'clojure-test-mode)
(eval-after-load 'clojure-mode
  '(define-key clojure-mode-map "\C-c\M-r" 'nrepl-switch-to-repl-buffer))

;; Clojure indentation rules
(eval-after-load 'clojure-mode
  '(define-clojure-indent
     (send-off 1)                                                    ; Core
     (GET 2) (POST 2) (PUT 2) (PATCH 2) (DELETE 2) (context 2)       ; Compojure
     (select 1) (insert 1) (update 1) (delete 1) (upsert 1) (join 1) ; Korma
     (clone-for 1)                                                   ; Enlive
     (up 1) (down 1) (alter 1) (table 1)                             ; Lobos
     ))

(add-hook 'clojure-mode-hook '(lambda () (setq indent-line-function 'lisp-indent-line-single-semicolon-fix)))

;; Autocompletion in nrepl
(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-mode-hook 'auto-complete-mode)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'auto-complete-mode)
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(eval-after-load 'auto-complete '(add-to-list 'ac-modes 'nrepl-mode))

;; Count hyphens, etc. as word characters in lisps
(add-hook 'clojure-mode-hook (lambda () (modify-syntax-entry ?- "w")))
(add-hook 'emacs-lisp-mode-hook (lambda () (modify-syntax-entry ?- "w")))
(add-hook 'scheme-mode-hook (lambda () (modify-syntax-entry ?- "w")))
(add-hook 'scheme-mode-hook (lambda () (modify-syntax-entry ?> "w")))

;; Treat underscores as word characters everywhere
(add-hook 'after-change-major-mode-hook (lambda () (modify-syntax-entry ?_ "w")))

;; Haskell
(eval-after-load 'haskell-mode
  '(progn
     (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
     (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
     (add-hook 'haskell-mode-hook 'ghc-init)
     (add-hook 'haskell-mode-hook
               (lambda ()
                 (setq haskell-program-name "cabal repl")
                 (setq haskell-indentation-left-offset 4)
                 (setq haskell-indentation-cycle-warn nil)
                 (setq haskell-indent-after-keywords (quote (("where" 2 0) ("of" 4) ("do" 4) ("mdo" 4)
                                                             ("rec" 4) ("in" 4 4) ("{" 4)
                                                             "if" "then" "else" "let")))
                 (setq haskell-indent-look-past-empty-line nil)))))

(eval-after-load 'inf-haskell
  '(define-key inferior-haskell-mode-map (kbd "TAB") 'dabbrev-expand))

;; Go
(add-hook 'before-save-hook 'gofmt-before-save)

;; Filetypes
(add-to-list 'auto-mode-alist '("\\.markdown$" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . gfm-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rkt$" . scheme-mode))

;; Nimrod
(load "~/.emacs.d/vendor/nimrod-mode.el")

(defun open-emacs-config ()
  (interactive)
  (find-file-other-window "~/.emacs.d/init.el"))

(defun open-notes-org-mode ()
  (interactive)
  (find-file "~/org/notes.org"))

(defun split-window-sensibly-reverse (&optional window)
  "Identical to the built-in function split-window-sensibly,
but prefers horizontal splits over vertical splits."
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

(defun lisp-indent-line-single-semicolon-fix (&optional whole-exp)
  "Identical to the built-in function lisp-indent-line,
but doesn't treat single semicolons as right-hand-side comments."
  (interactive "P")
  (let ((indent (calculate-lisp-indent)) shift-amt end
        (pos (- (point-max) (point)))
        (beg (progn (beginning-of-line) (point))))
    (skip-chars-forward " \t")
    (if (or (null indent) (looking-at "\\s<\\s<\\s<"))
        ;; Don't alter indentation of a ;;; comment line
        ;; or a line that starts in a string.
        ;; FIXME: inconsistency: comment-indent moves ;;; to column 0.
        (goto-char (- (point-max) pos))
      (if (listp indent) (setq indent (car indent)))
      (setq shift-amt (- indent (current-column)))
      (if (zerop shift-amt)
          nil
        (delete-region beg (point))
        (indent-to indent)))
    ;; If initial point was within line's indentation,
    ;; position after the indentation.  Else stay at same point in text.
    (if (> (- (point-max) pos) (point))
        (goto-char (- (point-max) pos)))))

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

;; Gmail
; Compose with C-x m
; Send with C-c C-c
; http://obfuscatedcode.wordpress.com/2007/04/26/configuring-emacs-for-gmails-smtp/
(require 'smtpmail)
(eval-after-load 'smtpmail
  '(setq user-mail-address "dmacdougall@gmail.com"
         send-mail-function 'smtpmail-send-it
         smtpmail-default-smtp-server "smtp.gmail.com"
         smtpmail-smtp-server "smtp.gmail.com"
         smtpmail-smtp-service 587
         smtpmail-debug-info t))

;; Create parent directories when saving a new file.
(add-hook 'before-save-hook
          (lambda ()
            (when buffer-file-name
              (let ((dir (file-name-directory buffer-file-name)))
                (when (and (not (file-exists-p dir))
                           (y-or-n-p (format "Directory %s does not exist. Create it?" dir)))
                  (make-directory dir t))))))
