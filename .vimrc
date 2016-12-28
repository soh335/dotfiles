set nocompatible

syntax on

scriptencoding utf-8
set encoding=utf-8
set backspace=indent,eol,start
set directory=$HOME/.vim/swap
if !isdirectory(&directory)
        call mkdir(&directory, 'p')
end
set undodir=$HOME/.vim/undo"
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

filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
source $VIMRUNTIME/macros/matchit.vim

call vundle#rc()

Plugin 'altercation/vim-colors-solarized'
Plugin 'Shougo/neocomplete.vim'

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#enable_auto_delimiter = 0

if !exists('g:neocomplete#delimiter_patterns')
  let g:neocomplete#delimiter_patterns= {}
endif
let g:neocomplete#delimiter_patterns.perl = ['.']

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.perl = '\h\w->\h\w|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.go = '[^.[:digit:] *\t]\.\w*'

inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

if !exists('g:neocomplete#sources#file_include#exprs')
  let g:neocomplete#sources#file_include#exprs = {}
endif

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)"
        \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)"
        \: "\<TAB>"

Plugin 'Shougo/neosnippet'
let g:neosnippet#snippets_directory = "~/.vim/snippets"
let g:neosnippet#disable_runtime_snippets = { 'perl' : 1 }

Plugin 'Shougo/neomru.vim'
let g:neomru#time_format = "(%Y/%m/%d %H:%M:%S) "
let g:neomru#file_mru_limit = 300

Plugin 'Shougo/unite-outline'
Plugin 'Shougo/unite.vim'

nnoremap <silent> <space>ff :<C-u>Unite file file/new -buffer-name=files<Cr>
nnoremap <silent> <space>fc :<C-u>UniteWithBufferDir file file/new -buffer-name=files<Cr>
nnoremap <silent> <space>fb :<C-u>Unite buffer<Cr>
nnoremap <silent> <space>fo :<C-u>Unite outline<Cr>
nnoremap <silent> <space>ft :<C-u>Unite tab<Cr>
nnoremap <silent> <space>fd :<C-u>Unite directory_mru -default-action=lcd -buffer-name=directory<Cr>
nnoremap <silent> <space>fm :<C-u>Unite file_mru -buffer-name=files<Cr>
nnoremap <silent> <space>fi :<C-u>Unite file_include -buffer-name=file_include<Cr>
nnoremap <silent> <space>fr :<C-u>Unite file_rec/async -buffer-name=files<Cr>
nnoremap <silent> <space>fj :<C-u>Unite jump -buffer-name=jump<Cr>
nnoremap <silent> <space>rp :<C-u>Unite ref/perldoc -buffer-name=ref<Cr>
nnoremap <silent> <space>ml :Unite file:<C-r>=g:memolist_path."/"<CR><CR>
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  nmap <buffer> <Esc><Esc> <Plug>(unite_all_exit)
  nmap <buffer> <C-c> <Plug>(unite_redraw)
  imap <buffer> <Esc><Esc> <Esc><Plug>(unite_all_exit)
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  nnoremap <silent><buffer><expr> <C-k> unite#do_action('vsplit')
  inoremap <silent><buffer><expr> <C-k> unite#do_action('vsplit')
  nnoremap <silent><buffer><expr> <C-j> unite#do_action('split')
  inoremap <silent><buffer><expr> <C-j> unite#do_action('split')
endfunction

call unite#custom#profile('default', 'context', {
                        \ 'start_insert': 1,
                        \ 'cursor_line_highlight' : 'PmenuSel',
                        \ })

Plugin 'tpope/vim-rails'
Plugin 'Shougo/vimproc'
Plugin 'dannyob/quickfixstatus'
Plugin 'h1mesuke/vim-alignta'
Plugin 'jceb/vim-hier'
Plugin 'kana/vim-gf-diff'
Plugin 'kana/vim-gf-user'
Plugin 'kana/vim-operator-replace'
Plugin 'kana/vim-operator-user'
Plugin 'kana/vim-submode'
" {{{ submode
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')

call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>+')
call submode#map('winsize', 'n', '', '-', '<C-w>-')
" }}}

Plugin 'kana/vim-textobj-diff'
Plugin 'kana/vim-textobj-entire'
Plugin 'kana/vim-textobj-fold'
Plugin 'kana/vim-textobj-function'
Plugin 'kana/vim-textobj-indent'
Plugin 'kana/vim-textobj-lastpat'
Plugin 'kana/vim-textobj-user'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mattn/gist-vim'
"let g:gist_open_browser_after_post = 1

Plugin 'mattn/webapi-vim'
Plugin 'mattn/wiseman-f-vim'
Plugin 'motemen/xslate-vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'osyo-manga/shabadou.vim'
Plugin 'osyo-manga/vim-watchdogs'
""{{{
"" watchdog.vim"
"let g:watchdogs_check_BufWritePost_enables = {
"      \ "perl" : 1,
"      \ "javascript" :0
"      \ }
"
"let g:quickrun_config = {
"      \ "watchdogs_checker/_" : {
"      \   "runner/vimproc/updatetime" : 40,
"      \   "outputter/quickfix/open_cmd" : '',
"      \   "hook/back_window/enable_exit" : 1,
"      \ },
"      \ "watchdogs_checker/perl-projectlibs" : {
"      \   "command" : "perl",
"      \   "exec" : "%c %o -cw -MProject::Libs %s:p",
"      \   "quickfix/errorformat": "%m\ at\ %f\ line\ %l%.%#",
"      \ },
"      \ "perl/watchdogs_checker" : {
"      \   "type": "watchdogs_checker/perl-projectlibs",
"      \ },
"      \}
"call watchdogs#setup(g:quickrun_config)
""}}}

Plugin 'pangloss/vim-javascript'
Plugin 't9md/vim-textmanip'

"{{{
" vim-textmanip
xmap <C-j> <Plug>(textmanip-move-down)
xmap <C-k> <Plug>(textmanip-move-up)
xmap <C-h> <Plug>(textmanip-move-left)
xmap <C-l> <Plug>(textmanip-move-right)

xmap <Space>d <Plug>(textmanip-duplicate-down)
nmap <Space>d <Plug>(textmanip-duplicate-down)
xmap <Space>D <Plug>(textmanip-duplicate-up)
nmap <Space>D <Plug>(textmanip-duplicate-up)
"}}}
"
Plugin 'taka84u9/unite-git'
Plugin 'thinca/vim-localrc'
Plugin 'thinca/vim-qfreplace'
Plugin 'thinca/vim-quickrun'
Plugin 'thinca/vim-ref'

" {{{ ref.vim
let g:ref_source_webdict_cmd = 'w3m -dump %s'
" }}}

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'tsukkee/unite-help'
Plugin 'tsukkee/unite-tag'
Plugin 'tyru/open-browser.vim'
"let g:openbrowser_open_filepath_in_vim = 0
"let g:netrw_nogx = 1 " disable netrw's gx mapping.
"nmap gx <Plug>(openbrowser-smart-search)
"vmap gx <Plug>(openbrowser-smart-search)

Plugin 'ujihisa/shadow.vim'
Plugin 'vim-jp/vimdoc-ja'
Plugin 'vim-jp/vital.vim'
Plugin 'vim-scripts/sudo.vim'

Plugin 'git@github.com:soh335/unite-outline-go.git'
Plugin 'git@github.com:soh335/unite-qflist.git'

Plugin 'fatih/vim-go'
" let g:go_fmt_command = "goimports"

" Plugin 'vim-perl/vim-perl'
Plugin 'mrk21/yaml-vim'

"call vundle#end()
filetype plugin indent on

""mapping{{{
"map ¥ \
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
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

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

""nmap <silent> :  <Plug>(cmdbuf-open-:)
"let plugin_dicwin_disable = 1
