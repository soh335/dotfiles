call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-rails'
Plug 'dannyob/quickfixstatus'
Plug 'h1mesuke/vim-alignta'
Plug 'kana/vim-gf-diff'
Plug 'kana/vim-gf-user'
Plug 'kana/vim-operator-replace'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-textobj-diff'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-fold'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-lastpat'
Plug 'kana/vim-textobj-user'
Plug 'mattn/webapi-vim'
Plug 'motemen/xslate-vim'
Plug 't9md/vim-textmanip'
Plug 'thinca/vim-localrc'
Plug 'thinca/vim-qfreplace'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-ref'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'vim-jp/vimdoc-ja'
Plug 'vim-scripts/sudo.vim'
Plug 'fatih/vim-go'
Plug 'mrk21/yaml-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --gocode-completer --tern-complete' }

call plug#end()

filetype plugin indent on
syntax on

scriptencoding utf-8
set encoding=utf-8
set backspace=indent,eol,start
set directory=$HOME/.vimswap
if !isdirectory(&directory)
        call mkdir(&directory, 'p')
end
set undodir=$HOME/.vimundo"
if !isdirectory(&undodir)
        call mkdir(&undodir, 'p')
end
set textwidth=0 "dont wrap lines
set nobackup
set history=500
set ruler
set expandtab
set autoindent
set smartindent
set ignorecase
set smartcase
set wrapscan
set incsearch
set listchars=tab:>-,trail:_
set list
set showcmd
set showmatch
set showmode
set hlsearch
nohlsearch
set laststatus=2
set wildmode=list:longest,full
set hidden
set autoread

""set foldmethod=syntax
""set foldcolumn=3

set visualbell t_vb=
set noerrorbells
set splitright
set splitbelow

set ambiwidth=double
set completeopt=menuone
set modeline
set notagbsearch
set clipboard+=unnamed

nnoremap <C-]> g<C-]>

let g:filetype_m = 'objc'

"prompt{{{
set ruf=%45(%12f%=\ %m%{'['.(&fenc!=''?&fenc:&enc).']'}\ %l-%v\ %p%%\ [%02B]%)
set statusline=%f:%{substitute(getcwd(),'.*/','','')}\ %m%=%{(&fenc!=''?&fenc:&enc).':'.strpart(&ff,0,1)}\ %l-%v\ %p%%\ %02B
"}}}

"id:parasporospa {{{
command! Utf8 e ++enc=utf-8
command! Euc e ++enc=euc-jp
command! Sjis e ++enc=cp932
command! Jis e ++enc=iso-2022-jp
command! WUtf8 w ++enc=utf-8 | e
command! WEuc w ++enc=euc-jp | e
command! WSjis w ++enc=cp932 | e
command! WJis w ++enc=iso-2022-jp | e
" }}}

let g:solarized_menu=0
colorscheme solarized

"ctrlp {{{
let g:ctrlp_map = '<Nop>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_show_hidden = 1
let g:ctrlp_max_files  = 1000000
let g:ctrlp_clear_cache_on_exit = 0
if executable("ag")
  let g:ctrlp_use_caching = 0
  let g:ctrlp_user_command = {
        \ 'types': {
        \ 1: ['.git', 'cd %s && git ls-files']
        \ },
        \ 'fallback': 'ag %s -i --nocolor --nogroup -g ""'
        \ }
endif
nnoremap <silent> <space>ff :<C-u>CtrlP<CR>
nnoremap <silent> <space>fm :<C-u>CtrlPMRUFiles<CR>
nnoremap <silent> <space>fb :<C-u>CtrlPBuffer<CR>
nnoremap <silent> <space>fd :<C-u>CtrlPDir<CR>
nnoremap <silent> <space>fc :<C-u>CtrlPCurFile<CR>
" }}}

""mapping{{{
"map _  <Plug>(operator-replace)
nmap j gj
nmap k gk
vmap j gj
vmap k gk
"noremap X ^x
"nmap n nzz
"nmap N Nzz

"search in visual mode by *
vnoremap * y/<C-r>0<CR>

"inoremap <C-w>  <C-g>u<C-w>
"inoremap <C-u>  <C-g>u<C-u>
"inoremap <C-x><C-l> <C-x><C-l>
nnoremap <Space>h :<C-u>help<Space>

nnoremap <Esc><Esc> :<C-u>nohlsearch<Return>
cnoremap <Up> <C-p>
cnoremap <Down> <C-n>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
"cnoremap <C-h> <Left>
"cnoremap <C-j> <Down>
"cnoremap <C-k> <Up>
"cnoremap <C-l> <Right>
"cnoremap <C-w> <S-Right>
"cnoremap <C-b> <S-Left>
"cnoremap <C-x> <Del>

"command! Swrite :w sudo:%
nnoremap Y y$
nmap <C-n> %
vmap <C-n> %
"inoremap <C-j> <Esc>
"imap <C-$> <Plug>IMAP_JumpForward
""}}}
"
"command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))
"nnoremap <expr> <space>rw ':Rename '.expand('%:h').'/'
"

" 前回終了したカーソル行に移動
autocmd BufReadPost * if &filetype != "gitcommit" && line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

autocmd FileType ruby,eruby setl tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType markdown setl tabstop=4 softtabstop=4 shiftwidth=2
autocmd FileType coffee setl tabstop=2 softtabstop=2 shiftwidth=2

autocmd FileType perl setl tabstop=4 softtabstop=4 shiftwidth=4
let g:perl_fold = 1
let g:perl_nofold_packages = 1
let g:perl_nofold_subs = 1

autocmd FileType go setlocal noexpandtab

"{{{for quickfix mapping
function! s:QuickFixMap()
  nnoremap <buffer><space>q :<C-u>ccl<cr>
  nnoremap <buffer><space>cq :cexpr ''<CR>
endfunction

autocmd FileType qf call s:QuickFixMap()
"}}}

command! -nargs=1 ChangeIndent setl tabstop=<args> shiftwidth=<args> softtabstop=<args>

source $VIMRUNTIME/macros/matchit.vim
