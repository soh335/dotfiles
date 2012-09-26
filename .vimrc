"set t_Co=256
" setting{{{
set nocompatible
filetype off
set rtp+=~/.vim/vundle.git/
call vundle#rc()

if filereadable($HOME."/.vim/vundlerc")
  source $HOME/.vim/vundlerc
endif

filetype plugin indent on
syntax on

set backspace=indent,eol,start 
highlight Pmenu ctermbg = 5
highlight PmenuSel ctermbg = 1
highlight PMenuSbar ctermbg = 4
highlight StatusLine ctermbg=1
set directory-=.
set iminsert=0
set imsearch=0
set imdisable
set textwidth=0
set nobackup
set history=500
set ruler
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
set ignorecase
set smartcase
set wrapscan
set incsearch
"set listchars=tab:\\ 
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
"set foldmethod=syntax
"set foldcolumn=3
"set title
"au BufNewFile,BufRead * set iminsert=0
"set matchpairs+=<:>
set visualbell
set splitright
set splitbelow
set pumheight=20
set ambiwidth=double
set completeopt=menuone,preview
set cmdwinheight=3
set modeline
set notagbsearch
if has('persistent_undo')
  set undodir=./.vimundo,~/.vimundo
endif
"}}}

"prompt{{{
set ruf=%45(%12f%=\ %m%{'['.(&fenc!=''?&fenc:&enc).']'}\ %l-%v\ %p%%\ [%02B]%)
set statusline=%f:%{substitute(getcwd(),'.*/','','')}\ %m%=%{(&fenc!=''?&fenc:&enc).':'.strpart(&ff,0,1)}\ %l-%v\ %p%%\ %02B
"}}}

"mapping{{{
map ¥ \
map _  <Plug>(operator-replace)
nmap j gj
nmap k gk
vmap j gj
vmap k gk
noremap X ^x
nmap n nzz
nmap N Nzz
if has('mac') && !has('gui')
  nnoremap <silent> <Space>y :.w !pbcopy<CR><CR>
  vnoremap <silent> <Space>y :w !pbcopy<CR><CR>
  nnoremap <silent> <Space>p :r !pbpaste<CR>
  vnoremap <silent> <Space>p :r !pbpaste<CR>
  " GVim(Mac & Win)
else
  noremap <Space>y "+y
  noremap <Space>p "+p
endif
nmap ,e :execute '!' &ft ' %'<CR>
"id:parasporospa
command! Utf8 e ++enc=utf-8
command! Euc e ++enc=euc-jp
command! Sjis e ++enc=cp932
command! Jis e ++enc=iso-2022-jp
command! WUtf8 w ++enc=utf-8 | e
command! WEuc w ++enc=euc-jp | e
command! WSjis w ++enc=cp932 | e
command! WJis w ++enc=iso-2022-jp | e

"search in visual mode by *
vnoremap * y/<C-r>0<CR>

inoremap <C-w>  <C-g>u<C-w>
inoremap <C-u>  <C-g>u<C-u>
inoremap <C-x><C-l> <C-x><C-l>
nnoremap <Space>h :<C-u>help<Space>
nnoremap <Space>m :<C-u>marks<CR>
"nnoremap ,r :<C-u>registers<CR>
nnoremap <Space>w :<C-u>write<CR>
nnoremap <Space>W :<C-u>write!<CR>
nnoremap <Space>q :<C-u>quit<CR>
nnoremap <Space>Q :<C-u>quit!<CR>
nnoremap <Space>bn :<C-u>bnext<CR>
nnoremap <Space>bp :<C-u>bprevious<CR>
nnoremap <Space>bd :<C-u>bdelete<CR>

nnoremap <Esc><Esc> :<C-u>nohlsearch<Return>
cnoremap <Up> <C-p>
cnoremap <Down> <C-n>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>
cnoremap <C-w> <S-Right>
cnoremap <C-b> <S-Left>
cnoremap <C-x> <Del>

command! Swrite :w sudo:%
nnoremap Y y$
nmap <C-n> %
vmap <C-n> %
nnoremap <Space>no :<C-u>set nu!<CR>
nnoremap <Space>np :<C-u>set paste!<CR>
inoremap <C-j> <Esc>
imap <C-$> <Plug>IMAP_JumpForward
"}}}

command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))
nnoremap <expr> <space>rw ':Rename '.expand('%:h').'/'

"{{{
" 文字コード関連
" from ずんWiki http://www.kawaz.jp/pukiwiki/?vim#content_1_7
" 文字コードの自動認識
if !has('gui_macvim') && !has('kaoriya')
  if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
  endif
  if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    " iconvがeucJP-msに対応しているかをチェック
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
      let s:enc_euc = 'eucjp-ms'
      let s:enc_jis = 'iso-2022-jp-3'
      "noomnifunc iconvがJISX0213に対応しているかをチェック
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
      let s:enc_euc = 'euc-jisx0213'
      let s:enc_jis = 'iso-2022-jp-3'
    endif
    " fileencodingsを構築
    if &encoding ==# 'utf-8'
      let s:fileencodings_default = &fileencodings
      let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
      let &fileencodings = &fileencodings .','. s:fileencodings_default
      unlet s:fileencodings_default
    else
      let &fileencodings = &fileencodings .','. s:enc_jis
      set fileencodings+=utf-8,ucs-2le,ucs-2
      if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
        set fileencodings+=cp932
        set fileencodings-=euc-jp
        set fileencodings-=euc-jisx0213
        set fileencodings-=eucjp-ms
        let &encoding = s:enc_euc
        let &fileencoding = s:enc_euc
      else
        let &fileencodings = &fileencodings .','. s:enc_euc
      endif
    endif
    " 定数を処分
    unlet s:enc_euc
    unlet s:enc_jis
  endif
  " 日本語を含まない場合は fileencoding に encoding を使うようにする
  if has('autocmd')
    function! AU_ReCheck_FENC()
      if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
        let &fileencoding=&encoding
      endif
    endfunction
    autocmd BufReadPost * call AU_ReCheck_FENC()
  endif
  " 改行コードの自動認識
  set fileformats=unix,dos,mac
endif
  "}}}

" 前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

"{{{ rails.vimの設定
let g:rails_level=4
let g:rails_default_file="app/controllers/application.rb"
let g:rails_default_database="mysql"
"}}}

"{{{ rubycomplete.vim
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"}}}

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType php  set complete+=k~/.vim/dict/php.dict
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd User Symfony10 setlocal tags+=$HOME/tags/symfony10.tags
autocmd User Symfony14 setlocal tags+=$HOME/tags/symfony14.tags

"for cakephp
au BufNewFile,BufRead *.thtml setfiletype php
au BufNewFile,BufRead *.ctp setfiletype php

au BufNewFile,BufRead *.tt setfiletype html
au BufNewFile,BufRead *.mt setfiletype html
au BufNewFile,BufRead *.ejs setfiletype html
au BufNewFile,BufRead *.psgi setfiletype perl
au BufNewFile,BufRead *.kml setfiletype xml
au BufNewFile,BufRead *.r set filetype=r

"smartchr plugin
"inoremap <expr> = smartchr#one_of(' = ', ' == ', ' === ', '=')

"{{{
"http://subtech.g.hatena.ne.jp/secondlife/20090503/1241321929
function! WordCount()
  let lines = getline('0', '$')
  let c = 0
  for line in lines
    let c += strlen(substitute(line, ".", "x", "g"))
  endfor
  echo c
endfunction
command! WordCount :call WordCount()
"}}}

"{{{ symfony.vim map
let g:vim_symfony_default_search_action_top_direction = 1
let g:vim_symfony_autocmd_version = 1
let g:vim_symfony_auto_search_root_dirctory = 1
"let g:vim_symfony_fuf = 1
nnoremap <silent><space>sv :<C-u>Sview<CR>
nnoremap <silent><space>sa :<C-u>Saction<CR>
nnoremap <silent><space>sm :<C-u>Smodel<CR>
nnoremap <silent><space>sp :<C-u>Spartial<CR>
nnoremap <silent><space>sc :<C-u>Scomponent<CR>
"let g:symfony_snipmate = 1
"let g:symfony_filetype = 1
"}}}

"{{{ vim-latex
"http://vim.g.hatena.ne.jp/y_yanbe/20080918/1221724545
"set shellslash
"set grepprg=grep\ -nH\ $*
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf = 'dvipdfmx $*.dvi'
let g:Tex_BibtexFlavor = 'jbibtex'
let g:Tex_CompileRule_dvi = 'platex-utf8 -interaction-nonstopmode $*'
let g:Tex_FormatDependency_pdf='dvi,pdf'
let g:Tex_ViewRule_pdf = 'open -a /Applications/Preview.app'
let g:Tex_IgnoredWarnings =
      \"Underfull\n".
      \"Overfull\n".
      \"specifier changed to\n".
      \"You have requested\n".
      \"Missing number, treated as zero.\n".
      \"There were undefined references\n".
      \"Citation %.%# undefined\n".
      \'LaTeX Font Warning:'"
let g:Tex_IgnoreLevel = 8
function! CompileAndView()
  execute 'w'
  call Tex_RunLaTeX()
  if !empty(getqflist()) 
    return 0
  endif
  call Tex_ViewLaTeX()
endfunction
"autocmd FileType tex nnoremap <leader>r :call CompileAndView()<CR>
"}}}

"{{{for quickfix mapping
function! s:QuickFixMap()
  nnoremap <buffer><space>q :<C-u>ccl<cr>
  nnoremap <buffer><space>cq :cexpr ''<CR>
endfunction

autocmd FileType qf call s:QuickFixMap()
"}}}

function! s:CreateDirAndWrite()
  let dir = expand("%:p:h")
  if isdirectory(dir) == 0
    call mkdir(dir, 'p')
  endif
  execute ':w'
endfunction
command! CreateDirAndWrite :call s:CreateDirAndWrite()

" {{{ ref.vim
"let g:ref_phpmanual_path = 
let g:ref_phpmanual_cmd = 'w3m -dump %s'
"let g:ref_jquery_path = 
let g:ref_jquery_cmd = 'w3m -dump %s'
let g:ref_source_webdict_cmd = 'w3m -dump %s'
nnoremap <space>rp :<C-u>Ref phpmanual 
" }}}

" {{{ php-doc.vim
let g:pdv_cfg_Type = "string"
let g:pdv_cfg_Package = ""
let g:pdv_cfg_Version = "$id$"
"let g:pdv_cfg_Author = "fugafuga <fugafuga@your.mailaddress.com>"
"let g:pdv_cfg_Copyright = "Copyright (C) 2007 Hoge Corporation. All Rights Reserved."
"let g:pdv_cfg_License = "PHP Version 5.0 {@link http://www.php.net/license/5_0.txt}"
nnoremap ,d :call PhpDocSingle()<CR>
" }}}

"nmap <silent> :  <Plug>(cmdbuf-open-:)
let plugin_dicwin_disable = 1

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_manual_completion_start_length = 3
let g:neocomplcache_enable_auto_delimiter = 0
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.perl = '\h\w->\h\w|\h\w*::'

inoremap <expr><BS> neocomplcache#smart_close_popup()."\<BS>"
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"


source $VIMRUNTIME/macros/matchit.vim
let g:filetype_m = 'objc'

" :HighlightWith {filetype} ['a 'b] XXX: Don't work in some case."{{{
command! -nargs=+ -range=% HighlightWith <line1>,<line2>call s:highlight_with(<q-args>)
xnoremap <space>h :HighlightWith<Space><C-f>

function! s:highlight_with(args) range
  if a:firstline == 1 && a:lastline == line('$')
    return
  endif
  let c = get(b:, 'highlight_count', 0)
  let ft = matchstr(a:args, '^\w\+')
  if globpath(&rtp, 'syntax/' . ft . '.vim') == ''
    return
  endif
  unlet! b:current_syntax
  let save_isk= &l:isk " For scheme.
  execute printf('syntax include @highlightWith%d syntax/%s.vim',
        \ c, ft)
  let &l:isk= save_isk
  execute printf('syntax region highlightWith%d start=/\%%%dl/ end=/\%%%dl$/ '
        \ . 'contains=@highlightWith%d',
        \ c, a:firstline, a:lastline, c)
  let b:highlight_count = c + 1
endfunction
"}}}


" {{{ unite
" call unite#set_substitute_pattern('files', '[[:alnum:]]', '*\0', 100)

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
  nmap <buffer> <Esc><Esc> <Plug>(unite_exit)
  imap <buffer> <Esc><Esc> <plug>(unite_exit)
  nnoremap <silent><buffer><expr> <C-k> unite#do_action('vsplit')
  inoremap <silent><buffer><expr> <C-k> unite#do_action('vsplit')
  nnoremap <silent><buffer><expr> <C-j> unite#do_action('split')
  inoremap <silent><buffer><expr> <C-j> unite#do_action('split')
endfunction
let g:unite_source_file_mru_limit = 200
let g:unite_enable_start_insert = 1
" }}}


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
command! -nargs=1 ChangeIndent :setl ts=<args> |setl sw=<args>

let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

let perl_fold = 1
let perl_nofold_packages = 1
let perl_nofold_subs = 1

let g:gist_open_browser_after_post = 1

" {{{
" for tex 
function! s:subsitute_interpunction()
  let pos = getpos(".")
  silent execute "try | %s/。/．/g | catch | endtry"
  silent execute "try | %s/、/，/g | catch | endtry"
  call setpos(".", pos)
endfunction

autocmd! BufWrite *.tex call s:subsitute_interpunction()
" }}}

"{{{
"for quickhl
command! QuickhlAddLastPat execute "QuickhlAdd!" . @/
nmap <Space>m <Plug>(quickhl-toggle)
xmap <Space>m <Plug>(quickhl-toggle)
nmap <Space>M <Plug>(quickhl-reset)
xmap <Space>M <Plug>(quickhl-reset)
"}}}
"

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

"{{{
let g:loaded_perl_syntax_checker = 1
function! SyntaxCheckers_perl_GetLocList()
  let makeprg = 'perl ' . $HOME . "/.vim/bin/perl_projectlibs.pl"
  if exists("b:syntastic_perl_lib_dirs")
    let makeprg .= " " . join(map(b:syntastic_perl_lib_dirs, '"--libdir " . v:val'), " ")
  endif

  let makeprg .= " " . shellescape(expand("%"))
  let errorformat =  '%f:%l:%m'

  return SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat })
endfunction
"}}}

source $HOME/.vimrc.local
