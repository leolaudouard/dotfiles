set undofile
set undodir=~/.vim/undodir
set number
set number
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab
set nobackup
colorscheme pablo
augroup toogle_relative_number
autocmd InsertEnter * :setlocal norelativenumber
autocmd InsertLeave * :setlocal relativenumber
set showmode
let mapleader = ","

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
" Buffer Navgiation
" =======================================================================
noremap <C-j> <C-W>j<CR>
noremap <C-k> <C-W>k<CR>
noremap <C-h> <C-W>h<CR>
noremap <C-l> <C-W>l<CR>
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/<C-r><C-w>/g<c-f>F/h

nnoremap <Left> :echo "That's h"<CR>
nnoremap <Right> :echo "That's l"<CR>
nnoremap <Up> :echo "That's k"<CR>
nnoremap <Down> :echo "That's j"<CR>

" Language Support
" =======================================================================
Plug 'sheerun/vim-polyglot'
Plug 'derekwyatt/vim-scala'
Plug 'dense-analysis/ale'
" {{{
noremap gd :ALEGoToDefinition<cr>
nnoremap gr :ALEFindReferences<cr>
nmap <silent> gN <Plug>(ale_previous_wrap)
nmap <silent> gn <Plug>(ale_next_wrap)

let g:ale_set_highlights = 0
let g:ale_linters = {}
let g:ale_fixers = {}
" Elixir
let g:ale_elixir_elixir_ls_release = "/home/leo/elixir-ls/rel"
let g:ale_elixir_elixir_ls_config = { 'elixirLS': { 'dialyzerEnabled': v:false } }
let g:ale_linters.elixir = ['elixir-ls', 'credo']
let g:ale_fixers.elixir = ['mix_format']

" TypeScript
let g:ale_typescript_prettier_use_local_config = 1
let g:ale_linters.typescript = ['tsserver']
let g:ale_fixers.typescript = ['prettier']
nmap <C-L> <Plug>(ale_fix)
" }}}

" Text Navigation
" =======================================================================

Plug 'easymotion/vim-easymotion'
" {{{
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_smartcase = 1
  let g:EasyMotion_off_screen_search = 0
  nmap ; <Plug>(easymotion-s2)
  map f <Plug>(easymotion-bd-f)
" }}}
" Text Manipulation
" =======================================================================
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'
Plug 'raimondi/delimitmate'
Plug 'mg979/vim-visual-multi'
" File Navigation
" =======================================================================
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" {{{
  let g:fzf_prefer_tmux = 1
  let g:fzf_nvim_statusline = 0 " disable statusline overwriting

  nnoremap <silent> <leader><space> :GFiles<CR>
  nnoremap <silent> <leader>a<space> :Files<CR>

  nnoremap <silent> K :call SearchWordWithAg()<CR>
  vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
  function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
  endfunction

  function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Ag' selection
  endfunction

  function! SearchWithAgInDirectory(...)
    call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
  endfunction
  command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)
" }}}

call plug#end()

