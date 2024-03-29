(require 'smartparens)
(require 'request)
(require 'apheleia)
(require 'flycheck-posframe)

;; General configs

(setq user-full-name "Celso Bonutti"
      user-mail-address "i.am@cel.so")
(let ((font-size (if IS-MAC 15 17)))
  (setq doom-font (font-spec :family "Iosevka" :size font-size)))
(setq org-directory "~/org/")
(setq display-line-numbers-type 'relative)
(setq-default iden-tabs-mode nil)
(setq-default tab-width 2)
(setq ident-line-function 'insert-tab)
(apheleia-global-mode +1)
(use-package circadian
  :ensure t
  :config
  (setq calendar-latitude -12.96)
  (setq calendar-longitude -38.50)
  (setq circadian-themes '((:sunrise . doom-nord-light)
                           (:sunset  . doom-nord)))
  (circadian-setup))

;; Copilot

(setq copilot-node-executable "/Users/dokkora/Library/Caches/fnm_multishells/46084_1668533188118/bin/node")

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         :map copilot-completion-map
         ("<tab>" . 'copilot-accept-completion)
         ("TAB" . 'copilot-accept-completion)))

;; Company

(setq company-tooltip-flip-when-above t)

;; General LSP UI/Flycheck configs

(flycheck-posframe-configure-pretty-defaults)

(setq
 lsp-ui-sideline-enable nil
 lsp-ui-doc-mode nil
 flycheck-navigation-minimum-level 'error
 flycheck-popup-tip-mode nil
 flycheck-highlighting-mode 'lines
 flycheck-posframe-position 'point-bottom-left-corner
 flycheck-posframe-max-width 80
 flycheck-posframe-max-height 25)


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

;; Haskell mode configs

(after! (smartparens haskell-mode)
  (sp-with-modes '(haskell-mode haskell-interactive-mode)
    (sp-local-pair "'" "'" :actions :rem)))



;; Elm mode configs

(setq elm-mode-hook '(elm-indent-simple-mode))

;; Vue/Web mode configs

(add-hook 'vue-mode-hook #'lsp!)

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
         (buffer-local-value 'major-mode (window-buffer window))))
   (window-list)))


(defun racket-run-and-scroll ()
  (interactive)
  (save-selected-window
    (racket-run)
    (go-to-racket-repl)
    (goto-char (point-max))))

;; (add-hook 'racket-mode-hook #'racket-unicode-input-method-enable)
;; (add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)

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

;; Lean4 mode

(use-package! lean4-mode
  :mode ("\\.lean\\'" . lean4-mode))


;; Io mode

(use-package! io-mode
  :mode ("\\.l?io\\'" . io-mode)
  :config

  (add-hook 'io-mode-hook #'display-line-numbers-mode))


;; Ruby mode

(setq rubocop-autocorrect-on-save nil)

(setq rubocop-format-on-save nil)

;; Formatters

(add-to-list 'apheleia-formatters
              '(fourmolu "fourmolu" "--stdin-input-file" (or (buffer-file-name) (buffer-name))))

(add-to-list 'apheleia-formatters
              '(ormolu "ormolu" "--stdin-input-file" (or (buffer-file-name) (buffer-name))))

(add-to-list 'apheleia-formatters
             '(rubocop "rubocop" "--autocorrect" "--format" "quiet" "--stdin" (or (buffer-file-name) (buffer-name)) "--stderr"))

(add-to-list 'apheleia-formatters
             '(rescript "rescript" "format" "-stdin" (or (buffer-file-name) (buffer-name))))

(add-to-list 'apheleia-formatters
             '(raco-fmt "raco" "fmt" (or (buffer-file-name) (buffer-name))))

(add-to-list 'apheleia-mode-alist
              '(haskell-mode . fourmolu))

(add-to-list 'apheleia-mode-alist
             '(ruby-mode . rubocop))

(add-to-list 'apheleia-mode-alist
             '(rescript-mode . rescript))

(add-to-list 'apheleia-mode-alist
             '(racket-mode . raco-fmt))

(add-hook 'before-save-hook #'+format/buffer nil t)

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
         (buffer-local-value 'major-mode (window-buffer window))))
         
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
