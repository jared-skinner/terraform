(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(require 'evil)
(evil-mode t)


(require 'sublimity)
(require 'sublimity-scroll)
(require 'sublimity-map)
(require 'sublimity-attractive)

(sublimity-mode 1)

(setq sublimity-map-size 20)
(setq sublimity-map-fraction 0.3)
(setq sublimity-map-text-scale -7)

(sublimity-map-set-delay nil)

(sublimity-attractive-hide-bars)
(sublimity-attractive-hide-vertical-border)
(sublimity-attractive-hide-fringes)
(sublimity-attractive-hide-modelines)

(add-hook 'sublimity-map-setup-hook
          (lambda ()
            (setq buffer-face-mode-face '(:family "Monospace"))
            (buffer-face-mode)))

(setq sublimity-scroll-weight 10
      sublimity-scroll-drift-length 5)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Activate installed packages
(package-initialize)

(ensure-package-installed 'evil 'helm 'sublimity 'darktooth-theme)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("98a619757483dc6614c266107ab6b19d315f93267e535ec89b7af3d62fb83cad" default)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



(load-theme 'darktooth)

(global-linum-mode t)
