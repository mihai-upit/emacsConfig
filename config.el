;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(global-display-line-numbers-mode)

;;(map! :leader
;;      :desc "Connect with Wile" "..." #'wile-connect)

(setq shell-file-name (executable-find "bash"))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(setq doom-line-numbers-style 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(defvar asus (string= "antiloading" (setq h7 (message (user-login-name))))
        " wile package only works if you are on a machine with iwd and connman, exclusively
;; used for networking
;; also message saves logs and can be seen with view-echo-area-messages
;; user-login-name uses the environment variable $USER
;;user-login-name uses $USER environment variable
;;i have also decided to configure matlab only for asus machine, matlab is proprietary
;;you have to download it from your university website"

        )
(setq org-directory "~/org/")
;;"/home/antiloading/org/"
(package-initialize)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;; Hide the Symex menu by default

(add-hook 'after-init-hook 'my-after-init-hook)
(defun my-after-init-hook ()
  ;; Load packages or do other package-related configuration here
  (if asus (require 'wile "~/wile/wile/wile.el"))
  )
(setq iedit-toggle-key-default nil)
(setq symex-modal-backen 'hydra)
(setq symex-common-lisp-backend 'sly)
(setq hydra-is-helpful nil)
(setq yas-snippet-dirs '("~/.config/emacs/modules/editor/snippets"))


(add-hook 'after-change-major-mode-hook
   (lambda ()
     (modify-syntax-entry ?- "w")))

(use-package symex
  :config (symex-initialize)
  (global-set-key (kbd "C-c [") 'symex-mode-interface)
  (global-set-key (kbd "C-{") 'hydra-symex/symex-emit-backward)
  (global-set-key (kbd "C-}") 'hydra-symex/symex-emit-forward)
  :custom (symex-modal-backend 'hydra)
  (symex-highlight-p nil)
  (symex-quote-prefix-list (list "'" "`" "#'" "#`"))
  (symex-unquote-prefix-list (list "," ",@" "#,@"))
  )
(when asus (add-to-list 'exec-path "~/matlab/bin/matlab")
      ;;"/home/antiloading/matlab/bin/matlab"
      ;; (require 'matlab-mode-autoloads)
      (add-to-list
       'auto-mode-alist
       '("\\.m$" . matlab-mode))
      (setq matlab-indent-function t)
      (setq matlab-shell-command "~/matlab/bin/matlab")
      ;;"/home/antiloading/matlab/bin/matlab"
      (setq matlab-shell-command-switches '("-nodesktop" "-nosplash"))
      (setq matlab-shell-enable-gud-flag nil)
      (setq matlab-shell-debug t)


      (global-set-key (kbd "C-c m") 'open-matlab-shell))


(beacon-mode 1)

(evil-define-key 'normal symex-mode-map
  (kbd "<escape>") 'symex-mode-interface)

(evil-define-key 'insert symex-mode-map
  (kbd "<escape>") 'symex-mode-interface)

(defun insert-escaped-double-quote ()
 "Insert an escaped double quote."
 (interactive)
 (insert "\\\""))

(global-set-key (kbd "C-c '")
        'insert-escaped-double-quote)


;(defun my-hydra-symex-body () ;; fix integerp issue with symex-height command
;  "Set symex height automatically."
;  (lambda ()
;  (interactive)
;  (symex-height)
;  (hydra-symex/body)))
;
;(global-set-key (kbd "C-c [") (lambda ()
;        (interactive)
;        (hydra-symex/body))) ;; symbolic expression editor


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
