set nocompatible " 关闭 vi 兼容模式
set noswapfile

filetype off                    " required!
" 自动插件机制 [Vundle] http://zuyunfei.com/2013/04/12/killer-plugin-of-vim-vundle/  https://github.com/asins/vim/blob/master/_vimrc
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Launch `vim` and run `:PluginInstall`  or   To install from command line: `vim +PluginInstall +qall`
Plugin 'VundleVim/Vundle.vim' "required
" My Plugin
Plugin 'fatih/vim-go'
" 树形列表
Plugin 'scrooloose/nerdtree'
" 智能注释插件
Plugin 'scrooloose/nerdcommenter'
" tagbar
Plugin 'majutsushi/tagbar'
" 文档注释插件
Plugin 'DoxygenToolkit.vim'
" HTML 代码生成器 ZenCoding.vim 很酷的插件，HTML代码生成 https://raw.githubusercontent.com/mattn/emmet-vim/master/TUTORIAL http://www.jianshu.com/p/67fa1e2114c5
Plugin 'mattn/emmet-vim'
" PHP 代码格式化插件
Plugin 'stephpy/vim-php-cs-fixer'
" 状态栏
Plugin 'bling/vim-airline'
"顶部tab页切换
Plugin 'mkitt/tabline.vim'
" 语法检查
Plugin 'scrooloose/syntastic'
" supertab
Plugin 'ervandew/supertab'
" 包括
Plugin 'tpope/vim-surround'
" 文件查找
Plugin 'kien/ctrlp.vim'
" vim颜色方案
Plugin 'flazz/vim-colorschemes'
" yaml
Plugin 'stephpy/vim-yaml'
call vundle#end()            " required

" 插件安装
nnoremap <leader>pg :PluginInstall<CR>

filetype plugin indent on " 开启插件,打开文件类型检测功能
syntax on " 自动语法高亮
set number " 显示行号
set cursorline " 突出显示当前行
set ruler " 打开状态栏标尺
set shiftwidth=4 " 设定 << 和 >> 命令移动时的宽度为 4
set softtabstop=4 " 使得按退格键时可以一次删掉 4 个空格
set tabstop=4 " 设定 tab 长度为 4
set expandtab " tab转换成空格 Ctrl-V<Tab>可以输入真正的空格
set nobackup " 覆盖文件时不备份
set autochdir " 自动切换当前目录为当前文件所在的目录
set backupcopy=yes " 设置备份时的行为为覆盖
set ignorecase smartcase " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
"set nowrapscan " 禁止在搜索到文件两端时重新搜索
set incsearch " 输入搜索内容时就显示搜索结果
set hlsearch " 搜索时高亮显示被找到的文本
set noerrorbells " 关闭错误信息响铃
set novisualbell " 关闭使用可视响铃代替呼叫
set t_vb= " 置空错误铃声的终端代码
" set showmatch " 插入括号时，短暂地跳转到匹配的对应括号
" set matchtime=2 " 短暂跳转到匹配括号的时间
set magic " 设置魔术
"set hidden " 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
set smartindent " 开启新行时使用智能自动缩进
set backspace=indent,eol,start " 不设定在插入状态无法用退格键和 Delete 键删除回车符
set cmdheight=1 " 设定命令行的行数为 1
set laststatus=2 " 显示状态栏 (默认值为 1, 无法显示状态栏)

set foldenable " 开启折叠 http://yyq123.blogspot.com/2011/09/vim-fold.html
set foldmethod=marker "indent manual syntax  设置语法折叠
"set foldcolumn=1 " 设置折叠区域的宽度
setlocal foldlevel=1 " 设置折叠层数为
" set foldclose=all " 设置为自动关闭折叠
" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" 设置终端颜色
set t_Co=256
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=utf-8,gbk,gb2312
endif

"窗口分割时,进行切换的按键热键需要连接两次,比如从下方窗口移动
"光标到上方窗口,需要<c-w><c-w>k,非常麻烦,现在重映射为<c-k>,切换的
"时候会变得非常方便.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 全文搜索选中的文字
vnoremap <silent> <Leader>f y/<c-r>=escape(@", "\\/.*$^~[]")<cr><cr>
vnoremap <silent> <Leader>F y?<c-r>=escape(@", "\\/.*$^~[]")<cr><cr>

" Python 文件的一般设置，比如不要 tab 等
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab
autocmd FileType python map <F12> :!python %<CR>

" PHP 文件，F12执行本文件
autocmd FileType php map <F12> :!php %<CR>

"-----------------------------------------------------------------
" plugin - NERD_commenter.vim 注释代码用的，
" ca，在可选的注释方式之间切换，比如C/C++ 的块注释/* */和行注释//
" ,cc，注释当前行
" ,c，切换注释/非注释状态
" ,cs，以”性感”的方式注释
" ,cm 光标以下count行尝试添加块注释(7,cm)
" ,cA，在当前行尾添加注释符，并进入Insert模式
" ,cu，取消注释
" Normal模式下，几乎所有命令前面都可以指定行数
" Visual模式下执行命令，会对选中的特定区块进行注释/反注释
"-----------------------------------------------------------------
let NERDSpaceDelims=1 " 让注释符与语句之间留一个空格
let NERDCompactyComs=1 " 多行注释时样子更好看

"-----------------------------------------------------------------
" plugin - DoxygenToolkit.vim 由注释生成文档，并且能够快速生成函数标准注释
"-----------------------------------------------------------------
let g:DoxygenToolkit_authorName="zhouhaojie - zhouhaojie@360.cn"
let g:DoxygenToolkit_briefTag_funcName="yes"
map <leader>da :DoxAuthor<CR>
map <leader>df :Dox<CR>
map <leader>db :DoxBlock<CR>
map <leader>dc a /* */<LEFT><LEFT><LEFT>

" php语法格式化
nnoremap <leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <leader>pcf :call PhpCsFixerFixFile()<CR>

"-----------------------------------------------------------------
" plugin - nerdtree
"-----------------------------------------------------------------
let g:NERDTree_title="[NERDTree]"
let NERDTreeDirArrows=0
function! NERDTree_Start()
    exec 'NERDTree'
endfunction

function! NERDTree_IsValid()
    return 1
endfunction
nmap wm :NERDTreeToggle<CR>

"-----------------------------------------------------------------
" plugin - tagbar.vim 查看函数列表，需要ctags程序
"-----------------------------------------------------------------
let g:tagbar_ctags_bin = '/usr/bin/ctags'
nnoremap wl :TagbarToggle<CR>

"-----------------------------------------------------------------
" plugin - airline
"-----------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#syntastic#enabled = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'


"-----------------------------------------------------------------
" plugin - tabline
"-----------------------------------------------------------------
nmap <TAB> :bn<CR>
nmap <C-TAB> :bp<CR>
nmap <C-W> :bd<CR>

"-----------------------------------------------------------------
" plugin - syntastic
"-----------------------------------------------------------------
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 1

"-----------------------------------------------------------------
" plugin - supertab
"-----------------------------------------------------------------
let g:SuperTabDefaultCompletionType = "context"

" vim-go
let g:go_bin_path = expand("~/.gotools")
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
"let g:go_fmt_command = "goimports"

" Removes trailing spaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()
nnoremap <silent> <Leader>dww :call TrimWhiteSpace()<CR>

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" vimdiff
" highlight Normal term=none cterm=none ctermfg=White ctermbg=Black gui=none guifg=White guibg=Black
" highlight DiffAdd cterm=none ctermfg=fg ctermbg=Blue gui=none guifg=fg guibg=Blue
" highlight DiffDelete cterm=none ctermfg=fg ctermbg=Blue gui=none guifg=fg guibg=Blue
" highlight DiffChange cterm=none ctermfg=fg ctermbg=Blue gui=none guifg=fg guibg=Blue
" highlight DiffText cterm=none ctermfg=bg ctermbg=White gui=none guifg=bg guibg=White
