(require 'no-littering)
(no-littering-theme-backups)

(setq
 evil-want-C-u-scroll t
 evil-vsplit-window-right 1)
(require 'evil)
(evil-mode 1)
(evil-set-leader nil " ")
(evil-define-key '(normal visual motion) 'global (kbd "<leader>hf") 'describe-function)
(evil-define-key '(normal visual motion) 'global (kbd "<leader>hv") 'describe-variable)
(evil-define-key
  '(normal visual motion)
  'global
  (kbd "<leader>en")
  ;; Hack to make configuring at runtime easier
  (lambda() (interactive) (dired-at-point "~/.config/emacs/")))
(evil-define-key '(normal visual motion) 'global (kbd "<leader>wh") 'evil-window-left)
(evil-define-key '(normal visual motion) 'global (kbd "<leader>wl") 'evil-window-right)
(evil-define-key '(normal visual motion) 'global (kbd "<leader>wj") 'evil-window-down)
(evil-define-key '(normal visual motion) 'global (kbd "<leader>wk") 'evil-window-up)
(evil-define-key '(normal visual motion) 'global (kbd "<leader>wv") 'evil-window-vsplit)
(evil-define-key '(normal visual motion) 'global (kbd "<leader>ws") 'evil-window-split)
(evil-define-key '(normal visual motion) 'global (kbd "<leader>SPC") 'find-file-at-point)
(evil-define-key '(normal visual motion) 'global (kbd "<leader>lg") 'grep-find)
(evil-define-key
  '(normal visual motion)
  'global
  (kbd "<leader>rt")
  (lambda()
    (interactive)
    (progn
      (evil-window-vsplit)
       (ghostel)
      )))
(add-hook
 'eglot-connect-hook
 (progn
   (evil-define-key '(normal visual motion) 'global (kbd "<leader>rf") 'xref-find-references)
   (evil-define-key '(normal visual motion) 'global (kbd "<leader>rd") 'eglot-find-declaration)
   (evil-define-key '(normal visual motion) 'global (kbd "<leader>ri") 'eglot-find-implementation)
   (evil-define-key '(normal visual motion) 'global (kbd "<leader>rT") 'eglot-find-typeDeclaration)
   ))


(ido-mode 1)
(with-eval-after-load 'grep
    (grep-apply-setting
    'grep-find-command
    '("rg -n -H --no-heading -e '' $(git rev-parse --show-toplevel || pwd)" . 27)))


(require 'nix-mode)
(add-hook 'typescript-ts-mode-hook #'eglot-ensure)
(add-hook 'nix-mode-hook #'eglot-ensure)

(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)
(setq auto-save-default nil)
(auto-save-mode -1)
(menu-bar-mode 0)
(setq make-backup-files nil)

(require 'doom-themes)
(load-theme 'doom-one t)

