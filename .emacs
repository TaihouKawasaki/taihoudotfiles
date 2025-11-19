(add-to-list 'load-path "~/.emacs.d/loadpath/")
(require 'package)

;; Nice macro for updating lists in place.
(defmacro append-to-list (target suffix)
  "Append SUFFIX to TARGET in place."
  `(setq ,target (append ,target ,suffix)))

;; Set up emacs package archives with 'package
(append-to-list package-archives
                '(("melpa" . "http://melpa.org/packages/") ;; Main package archive
                  ("melpa-stable" . "http://stable.melpa.org/packages/") ;; Some packages might only do stable releases?
                  ("org-elpa" . "https://orgmode.org/elpa/"))) ;; Org packages, I don't use org but seems like a harmless default

(package-initialize)

;; Ensure use-package is present. From here on out, all packages are loaded
;; with use-package, a macro for importing and installing packages. Also, refresh the package archive on load so we can pull the latest packages.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq
 use-package-always-ensure t ;; Makes sure to download new packages if they aren't already downloaded
 use-package-verbose t) ;; Package install logging. Packages break, it's nice to know why.

;; Slurp environment variables from the shell.
;; a.k.a. The Most Asked Question On r/emacs
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(global-set-key (kbd "C-x w") 'elfeed)
(global-unset-key (kbd "C-z"))

(elfeed-update)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("ad7d874d137291e09fe2963babc33d381d087fa14928cb9d34350b67b6556b6d"
     default))
 '(elfeed-feeds
   '("http://anarchistnews.org/rss.xml"
     "https://theanarchistlibrary.org/feed"))
 '(package-selected-packages
   '(abyss-theme anki-editor company company-jedi elcord elfeed emms
		 exec-path-from-shell magit nov wanderlust)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package anki-editor
  :after org
  :bind (:map org-mode-map
	      ("C-z" . anki-editor-insert-note)
	      ("C-d" . anki-editor-set-deck)
	      ("C-p" . anki-editor-push-notes)
	      ("C-f" . "** Front
** Back")))

(require 'elcord)
(elcord-mode)

(add-hook 'after-init-hook 'global-company-mode)

(use-package nov
  :init
  (add-to-list 'auto-mode-alist' ("\\.epub\\'" . nov-mode)))

(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 1)

(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)

(emms-all)
(setq emms-player-list '(emms-player-vlc)
      emms-info-functions '(emms-info-native))


(set-frame-parameter nil 'alpha-background 50)
(add-to-list 'default-frame-alist '(alpha-background . 50))

(load-theme #'abyss t)

(require 'sunrise)
(add-to-list 'auto-mode-alist '("\\.zip\\'" . sunrise-virtual-mode))
