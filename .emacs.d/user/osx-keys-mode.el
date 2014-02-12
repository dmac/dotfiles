(provide 'osx-keys-mode)

;; OS X keybindings minor mode
;; http://stackoverflow.com/questions/683425/globally-override-key-binding-in-emacs
(defvar osx-keys-mode-map (make-keymap) "osx-keys-mode-keymap")

(define-key osx-keys-mode-map (kbd "M-`") 'other-frame)
(define-key osx-keys-mode-map (kbd "M-w") 'delete-frame)
(define-key osx-keys-mode-map (kbd "M-q") 'save-buffers-kill-terminal)
(define-key osx-keys-mode-map (kbd "M-N") 'new-frame)
(define-key osx-keys-mode-map (kbd "M-v") 'clipboard-yank)
(define-key osx-keys-mode-map (kbd "M-c") 'clipboard-kill-ring-save)

(define-minor-mode osx-keys-mode
  "A minor-mode for emulating osx keyboard shortcuts."
  t " osx" osx-keys-mode-map)

(defadvice load (after give-osx-keybindings-priority)
  "Try to ensure that osx keybindings always have priority."
  (if (not (eq (car (car minor-mode-map-alist)) 'osx-keys-mode))
      (let ((osx-keys (assq 'osx-keys-mode minor-mode-map-alist)))
        (assq-delete-all 'osx-keys-mode minor-mode-map-alist)
        (add-to-list 'minor-mode-map-alist osx-keys))))
(ad-activate 'load)
