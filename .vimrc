set undofile
set undodir=~/.vim/undodir
set number
set number
set softtabstop=2
set shiftwidth=2
set tabstop=2
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
noremap <C-J> <C-W>j<CR>
noremap <C-K> <C-W>k<CR>
noremap <C-H> <C-W>h<CR>
noremap <C-L> <C-W>l<CR>

" Language Support
" =======================================================================
Plug 'sheerun/vim-polyglot'
Plug 'derekwyatt/vim-scala'
Plug 'dense-analysis/ale'
" {{{
augroup elixir
  autocmd FileType elixir nnoremap gd :ALEGoToDefinition<cr>
  autocmd FileType elixir nnoremap Gd :ALEFindReferences<cr>
augroup END
	let g:ale_set_highlights = 0
  let g:ale_elixir_elixir_ls_release = "/home/leo/elixir-ls/rel"
  let g:ale_elixir_elixir_ls_config = { 'elixirLS': { 'dialyzerEnabled': v:false } }
  let g:ale_linters = {}
  let g:ale_linters.elixir = ['elixir-ls', 'credo']
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
  let g:fzf_nvim_statusline = 0 " disable statusline overwriting

  nnoremap <silent> <leader><space> :Files<CR>

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

