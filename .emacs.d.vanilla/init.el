:; This configures a very basic setup useful for independently testing features and packages.

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '())

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
