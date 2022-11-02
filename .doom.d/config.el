(require 'smartparens)
(require 'request)

;; General configs

(setq user-full-name "Celso Bonutti"
      user-mail-address "i.am@cel.so")
(let ((font-size (if IS-MAC 15 17)))
  (setq doom-font (font-spec :family "Iosevka" :size font-size)))
(setq doom-theme 'doom-nord-light)
(setq org-directory "~/org/")
(setq display-line-numbers-type 'relative)
(setq-default iden-tabs-mode nil)
(setq-default tab-width 2)
(setq ident-line-function 'insert-tab)
(flycheck-popup-tip-mode nil)

;; General keybindings

(map!
 :nv "q" #'evil-backward-word-begin
 :nv "Q" #'evil-backward-WORD-begin
 :nv "J" (kbd "10j")
 :nv "K" (kbd "10k")
 :nv "C-k" #'+lookup/documentation
 :nv "C-j" #'+lookup/definition
 :nv "H" #'evil-first-non-blank
 :nv "L" #'evil-last-non-blank
 :nv "X" (kbd "\"_Vx")
 "C-l" #'pdf-scroll-down
 "C-h" #'pdf-scroll-up
 "C-f" #'format-all-buffer
 "C-d" #'lsp-restart-workspace
 "C-7" #'sp-wrap-square
 "C-8" #'sp-wrap-curly
 "C-9" #'sp-wrap-round
 "C-0" #'sp-unwrap-sexp)

(map! :nv "7" #'sp-wrap-square
      :nv "8" #'sp-wrap-curly
      :nv "9" #'sp-wrap-round
      :nv "0" #'sp-unwrap-sexp)

(map! :map magit-mode-map
      :desc "Magit pull from upstream" :leader "g p" #'magit-pull-from-upstream
      :desc "Magit push to upstream" :leader "g P" #'magit-push-current-to-upstream)

;; General LSP UI configs

(add-hook! lsp-ui-sideline-mode
           (setq lsp-ui-sideline-diagnostic-max-lines 20))
(add-hook! lsp-ui-mode
  (lsp-ui-doc-mode -1))

;; Haskell mode configs

(after! (smartparens haskell-mode)
  (sp-with-modes '(haskell-mode haskell-interactive-mode)
    (sp-local-pair "'" "'" :actions :rem)))

;; Elm mode configs

(setq elm-mode-hook '(elm-indent-simple-mode))

;; Vue/Web mode configs

(add-hook 'vue-mode-hook #'lsp!)
(add-hook 'vue-mode +format-with nil)

(add-hook 'web-mode +format-with nil)

;; ReScript mode configs

(with-eval-after-load 'rescript-mode
  (require 'lsp-rescript)
  (add-hook 'rescript-mode-hook 'lsp-deferred)
  (add-hook 'rescript-mode-hook 'emmet-mode)
  (add-hook! lsp-ui-mode 'lsp-ui-doc-mode)
  (setq-hook! 'rescript-mode-hook emmet-expand-jsx-className? t)

  (map! :map emmet-mode-keymap
        :v [tab] #'emmet-wrap-with-markup
        :i [tab] #'+web/indent-or-yas-or-emmet-expand
        :i "M-E" #'emmet-expand-line))

(progn
  (customize-set-variable
   'lsp-rescript-server-command
   (list "node" (concat (getenv "HOME") "/lsp/rescript-vscode/server/out/server.js") "--stdio")))

(after! (smartparens rescript-mode)
  (sp-with-modes '(rescript-mode)
    (sp-local-pair "'" nil :actions nil)
    (sp-local-pair "<" ">")))

;; Rust mode configs

(after! rustic
  (setq lsp-rust-server 'rust-analyzer))

(setq rustic-lsp-server 'rust-analyzer)

;; Agda mode configs

(after! (smartparens agda2-mode)
  (sp-with-modes '(agda2-mode)
    (sp-local-pair "{-" "-")
    (sp-local-pair "{-#" "#-")
    (sp-local-pair "{-@" "@-")
    (sp-local-pair "`" nil :actions nil)
    (sp-local-pair "'" nil :actions nil)))

(after! lsp-mode
  (add-to-list 'lsp-language-id-configuration '(agda2-mode . "agda2"))

  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection "als")
    :major-modes '(agda2-mode)
    :server-id 'agda2-lsp)))

(add-hook 'agda2-mode-hook #'lsp!)

;; OCaml mode configs

(map!
 :mode utop-minor-mode
 "C-c C-r" #'utop-eval-region
 "C-c C-e" #'utop-eval-phrase
 "C-c C-b" #'utop-eval-buffer)

;; Prolog mode

(map!
 :leader
 :mode prolog-mode
 :desc "Runs current prolog query" "m l" #'ediprolog-dwim
 :desc "Clears buffer from previous ediprolog" "m r" #'ediprolog-remove-interactions)

(map!
 :mode prolog-mode
 :desc "Runs current prolog query" "C-c C-l" #'ediprolog-dwim
 :desc "Clears buffer from previous ediprolog" "C-c C-r" #'ediprolog-remove-interactions)

;; Racket mode

(map!
 :leader
 :mode racket-mode
 :desc "Runs racket file" "m l" #'racket-run-and-scroll
 :desc "Runs racket and moves to REPL" "m r" #'racket-run-and-switch-to-repl)

(map!
 :mode racket-mode
 :desc "Runs racket file" "C-c C-l" #'racket-run-and-scroll
 :desc "Runs racket and moves to REPL" "C-c C-r" #'racket-run-and-switch-to-repl)

(defun go-to-racket-repl ()
  (interactive)
  (select-window (find-racket-repl)))

(defun find-racket-repl ()
  (seq-find
   (lambda
     (window)
     (eq 'racket-repl-mode
         (buffer-local-value 'major-mode (window-buffer window))
         ))
   (window-list)))


(defun racket-run-and-scroll ()
  (interactive)
  (save-selected-window
    (racket-run)
    (go-to-racket-repl)
    (goto-char (point-max))))

(add-hook 'racket-mode-hook #'racket-unicode-input-method-enable)
(add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)

;; Idris2 mode

(use-package! idris2-mode
  :mode ("\\.l?idr\\'" . idris2-mode)
  :config

  (after! lsp-mode
    (add-to-list 'lsp-language-id-configuration '(idris2-mode . "idris2"))

    (lsp-register-client
     (make-lsp-client
      :new-connection (lsp-stdio-connection "idris2-lsp")
      :major-modes '(idris2-mode)
      :server-id 'idris2-lsp)))
  (setq lsp-semantic-tokens-enable t)

  (add-hook 'idris2-mode-hook #'lsp!))

;; Io mode

(use-package! io-mode
  :mode ("\\.l?io\\'" . io-mode)
  :config

  (add-hook 'io-mode-hook #'display-line-numbers-mode))


;; VTerm configurations

(defun vterm/split-right ()
  (interactive)
  (let* ((ignore-window-parameters t)
         (dedicated-p (window-dedicated-p)))
    (split-window-horizontally)
    (other-window 1)
    (+vterm/here default-directory)))

;; PDF mode configuration

(defun go-to-pdf ()
  (interactive)
  (select-window (find-pdf-window)))

(defun find-pdf-window ()
  (seq-find
   (lambda
     (window)
     (eq 'pdf-view-mode
         (buffer-local-value 'major-mode (window-buffer window))
         ))
   (window-list)))

(defun pdf-scroll-down ()
  (interactive)
  (save-selected-window
    (go-to-pdf)
    (pdf-view-next-page)))

(defun pdf-scroll-up ()
  (interactive)
  (save-selected-window
    (go-to-pdf)
    (pdf-view-previous-page)))

;; (add-hook 'pdf-view-mode-hook 'pdf-view-midnight-minor-mode)
