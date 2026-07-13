;; Hack to make dynamic feedback + storing config in nix store work
(setq user-emacs-directory "~/emacs.d")

;; Redirect native compilation cache
(when (and (fboundp 'startup-redirect-eln-cache)
           (fboundp 'native-comp-available-p)
           (native-comp-available-p))
  (startup-redirect-eln-cache
   (convert-standard-filename
    (expand-file-name  "var/eln-cache/" user-emacs-directory))))
