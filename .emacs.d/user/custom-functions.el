(defun open-emacs-config ()
  (interactive)
  (find-file-other-window "~/.emacs.d/init.el"))

(defun open-notes-org-mode ()
  (interactive)
  (find-file "~/org/notes.org"))

(defun powerline-custom-theme ()
  "Setup the default mode-line."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'powerline-active1 'powerline-inactive1))
                          (face2 (if active 'powerline-active2 'powerline-inactive2))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          powerline-default-separator
                                                          (car powerline-default-separator-dir))))
                          (separator-right (intern (format "powerline-%s-%s"
                                                           powerline-default-separator
                                                           (cdr powerline-default-separator-dir))))
                          (lhs (list (powerline-raw "%*" nil 'l)
                                     (powerline-buffer-id nil 'l)
                                     (powerline-raw " ")
                                     (funcall separator-left mode-line face1)
                                     (powerline-major-mode face1 'l)
                                     (powerline-raw " " face1)
                                     (funcall separator-left face1 face2)
                                     (powerline-minor-modes face2 'l)))
                          (rhs (list ;(powerline-vc face2 'r)
                                     (funcall separator-right face2 face1)
                                     (powerline-raw "%4l" face1 'l)
                                     (powerline-raw ":" face1 'l)
                                     (powerline-raw "%3c" face1 'r)
                                     (funcall separator-right face1 mode-line)
                                     (powerline-raw " ")
                                     (powerline-raw "%6p" nil 'r)
                                     (powerline-hud face2 face1))))
                     (concat (powerline-render lhs)
                             (powerline-fill face2 (powerline-width rhs))
                             (powerline-render rhs)))))))

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
