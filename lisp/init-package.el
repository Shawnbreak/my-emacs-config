;; Initialize package sources
(setq package-check-signature nil) ;; 个别时候会出现签名校验失败
(require 'package)

(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)
;; (setq package-archives '(("melpa" . "https://melpa.org/packages/")
;;			 ("org" . "https://orgmode.org/elpa/")
;;			 ("elpa" . "https://elpa.gnu.org/packages/")))



(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; (use-package command-log-mode)

(use-package ivy 
  :defer 1 
  :demand 
  :hook (after-init . ivy-mode) 
  :config 
  (ivy-mode 1) 
  (setq ivy-use-virtual-buffers t 
        ivy-initial-inputs-alist nil 
        ivy-count-format "%d/%d " 
        enable-recursive-minibuffers t 
        ivy-re-builders-alist '((t . ivy--regex-ignore-order))))

(use-package counsel 
  :after (ivy) 
  :bind (("M-x" . counsel-M-x) 
         ("C-x C-f" . counsel-find-file) 
         ("C-c f" . counsel-recentf)
         ("C-c g" . counsel-git)))

(use-package swiper 
  :after ivy 
  :bind (("C-s" . swiper) 
         ("C-r" . swiper-isearch-backward)) 
  :config (setq swiper-action-recenter t 
                swiper-include-line-number-in-search t))

(use-package which-key 
  :defer nil 
  :config (which-key-mode))

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (python-mode . lsp-deferred)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)


;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
;; (use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
;; (use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;;(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
;; (use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
;; (use-package which-key
;;    :config
;;    (which-key-mode))

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferre
;;(use-package lsp-java
;;  :defer t
;;  :init
;;  (setq lsp-java-server-install-dir
;;	"C:/Users/Shawn/Downloads/jdt-language-server-1.4.0-202109161824")
;;  :config (add-hook 'java-mode-hook 'lsp))
(use-package lsp-java
  :defer t
  :init
  (setq lsp-java-server-install-dir
        "C:/Users/Shawn/Downloads/jdt-language-server-1.4.0-202109161824")
  :hook (java-mode . (lambda ()
                       (require 'lsp-java)
                       (lsp-common-set))))

(load-theme 'gruvbox-dark-soft)

(provide 'init-package)
