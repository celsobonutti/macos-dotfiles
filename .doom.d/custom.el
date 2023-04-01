(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(fish-mode flycheck-pos-tip request))
 '(safe-local-variable-values
   '((lsp-elm-elm-path . lamdera)
     (eval add-to-list 'apheleia-mode-alist
      '(haskell-mode . ormolu))
     (+format-with . fourmolu)
     (format-all-formatters "Haskell" fourmolu)
     (lsp-haskell-formatting-provider . "fourmolu")
     (lsp-haskell-formatting-provider . "ormolu")
     (lsp-haskell-formatting-provider . "brittany")
     (lsp-disabled-clients ruby-ls)
     (evil-shift-width . 2)
     (lsp-elm-elm-path . "lamdera")))
 '(warning-suppress-types '((before-save-hook) (before-save-hook) (lsp-mode))))
 '(graphql-url "https://api.linear.app/graphql")
 '(graphql-extra-headers '((Authorization . "Bearer lin_api_vwgXerUHHyGm56QAjcfdteS1AXhF1B3qWFptbcKW")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 
