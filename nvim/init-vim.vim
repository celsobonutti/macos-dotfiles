set softtabstop=0
set smarttab
set autoindent
set number
set relativenumber
set tabstop=8
set expandtab
set shiftwidth=2
set ignorecase
set smartcase

let g:elm_format_autosave = 0
let g:vim_vue_plugin_use_typescript = 1
let g:vim_vue_plugin_highlight_vue_keyword = 1
let g:rust_recommended_style = 0
let mapleader = " "
syntax on

command Fmt :call CocAction('format')

noremap J 10j
noremap K 10k
noremap <leader>wl <C-W>l
noremap <leader>wh <C-W>h
noremap <leader>wj <C-W>j
noremap <leader>wk <C-W>k
noremap x x
noremap X dd
noremap L g_
noremap H ^
noremap q b
inoremap jj <Esc>
noremap T :tabnew<CR>
noremap W :tabclose<CR>

map <leader><leader> :GFiles --cached --others --exclude-standard<CR>
map <leader>/ :Ag<CR>
map <leader>op :CocCommand explorer<CR>
map <leader>, :Buffers<CR>
map <leader>hrr :source ~/.vimrc<CR> :echo "Reloaded configuration"<CR>
map <leader>bk :bd<CR>
map <leader>fr :History<CR>
map <leader>ws :split<CR>
map <leader>wv :vsplit<CR>
map <leader>wq :q<CR>

noremap <nowait><expr> <PAGEDOWN> coc#float#has_scroll() ? coc#float#scroll(1) : "\<PAGEDOWN>"
noremap <nowait><expr> <PAGEUP> coc#float#has_scroll() ? coc#float#scroll(0) : "\<PAGEUP>"

let g:LanguageClient_serverCommands = { 'haskell': ['haskell-language-server-wrapper', '--lsp'] }

let g:closetag_filenames = "*.html,*.jsx,*.tsx,*.vue,*.xhml,*.xml"
let g:closetag_regions = {
  \ 'typescript.tsx': 'jsxRegion,tsxRegion',
  \ 'javascript.jsx': 'jsxRegion',
  \ }

let g:closetag_emptyTags_caseSensitive = 1

let g:closetag_shortcut = '>'

let g:closetag_close_shortcut = '<leader>>'

set clipboard=unnamedplus
set clipboard+=unnamedplus

set dir=$HOME/.vim/tmp/swap
if !isdirectory(&dir) | call mkdir(&dir, 'p', 0700) | endif

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  Plug 'itchyny/lightline.vim'

  Plug 'pangloss/vim-javascript'

  Plug 'airblade/vim-gitgutter'

  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  Plug 'alvan/vim-closetag'

  Plug 'maxmellon/vim-jsx-pretty'

  Plug 'HerringtonDarkholme/yats.vim'

  Plug 'elixir-editors/vim-elixir'

  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

  Plug 'junegunn/fzf.vim'

  Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }

  Plug 'AndrewRadev/tagalong.vim'

  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

  Plug 'dracula/vim', { 'as': 'dracula' }

  Plug 'rescript-lang/vim-rescript'

  Plug 'jiangmiao/auto-pairs'
  
  Plug 'purescript-contrib/purescript-vim' 

  Plug 'direnv/direnv.vim'
call plug#end()
