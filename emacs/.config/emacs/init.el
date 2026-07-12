(require 'no-littering)
(no-littering-theme-backups)
;; Redirect native compilation cache
(when (and (fboundp 'startup-redirect-eln-cache)
           (fboundp 'native-comp-available-p)
           (native-comp-available-p))
  (startup-redirect-eln-cache
   (convert-standard-filename
    (expand-file-name  "var/eln-cache/" user-emacs-directory))))

(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)
(evil-set-leader nil " ")
(evil-define-key 'normal 'global (kbd "<leader>hf") 'describe-function)
(evil-define-key 'normal 'global (kbd "<leader>hv") 'describe-variable)
(evil-define-key
  'normal
  'global
  (kbd "<leader>en")
  (lambda() (interactive) (dired-at-point user-emacs-directory)))
(evil-define-key '(normal visual motion) 'global (kbd "<leader>wh") 'evil-window-left)
(evil-define-key '(normal visual motion) 'global (kbd "<leader>wl") 'evil-window-right)
(evil-define-key '(normal visual motion) 'global (kbd "<leader>wj") 'evil-window-down)
(evil-define-key '(normal visual motion) 'global (kbd "<leader>wk") 'evil-window-up)
(evil-define-key '(normal visual motion) 'global (kbd "<leader>wv") 'evil-window-vsplit)
(evil-define-key '(normal visual motion) 'global (kbd "<leader>ws") 'evil-window-split)
(evil-define-key '(normal visual motion) 'global (kbd "<leader>SPC") 'find-file-at-point)

(require 'nix-mode)
(add-hook 'typescript-ts-mode-hook #'eglot-enure)
(add-hook 'nix-mode-hook #'eglot-ensure)

(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)
(setq auto-save-default nil)
(auto-save-mode -1)
(menu-bar-mode 0)
(setq make-backup-files nil)

(require 'doom-themes)
(load-theme 'doom-one t)
