""""""""""""""""""""""""
"显示相关
syntax on "语法高亮
set backspace=indent,eol,start
set shortmess=atI " 启动的时候不显示那个援助乌干达儿童的提示
set showcmd         " 输入的命令显示出来，看的清楚些  
""set novisualbell    " 不要闪烁(不明白) 
set scrolloff =7 " 光标移动到buffer的顶部和底部时保持3行距离 
set statusline =%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容 
set laststatus =2    " 启动显示状态行(1),总是显示状态行(2)
set nocompatible "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限 
set autoread


" 显示中文帮助
set encoding=utf-8
"自动判断编码时，依次尝试一下编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set helplang=cn
set termencoding=utf-8

 " 自动缩进
 set autoindent
 set smartindent
 set cindent
 " Tab键的宽度
 set tabstop=2
 " 统一缩进为4
 set softtabstop=2
 set shiftwidth=2
 set smarttab
 set expandtab
" 显示行号
 set number
 set wrap
" 历史记录数
 set history=1000
 "语言设置
 set langmenu=zh_CN.UTF-8
" 侦测文件类型
 filetype on
" 载入文件类型插件
 filetype plugin on
" 为特定文件类型载入相关缩进文件
 filetype indent on
"启动自动补全
filetype plugin indent on
 " 去掉输入错误的提示声音
 set novisualbell
 set noerrorbells
 "取消备份
 set nobackup 
 set noswapfile
 "突出显示当前行
 "set cursorcolumn
 "set cursorline
 "退出vim后，内容显示在终端屏幕
 "set t_ti = t_te =
 set ignorecase "搜索忽略大小写
 set incsearch "即刻搜索
 set smartcase "有一个或以上大学字母是仍大小写敏感
 set showmatch " 高亮显示匹配的括号
 set matchtime=2 " 匹配括号高亮的时间（单位是十分之一秒）
 set foldenable
 set foldmethod=indent
 set foldlevel=99
 
 
 
 
 
 ""实用设置
 """"""""""""""""""
set magic
"自动补全配置
 set completeopt=preview,menu




"自动补全
"":inoremap ( ()<ESC>i
"":inoremap ) <c-r>=ClosePair(')')<CR>
"":inoremap { {<CR>}<ESC>O
"":inoremap } <c-r>=ClosePair('}')<CR>
"":inoremap [ []<ESC>i
"":inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap " ""<ESC>i
"":inoremap ' ''<ESC>i
""function! ClosePair(char)
""    if getline('.')[col('.') - 1] == a:char
"			return "\<Right>"
""    else
""			return a:char
""    endif
""endfunction




"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.py exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
"如果文件类型为.sh文件
if &filetype == 'sh'
	call setline(1,"\#!/bin/bash")
	call append(line("."), "")
    elseif &filetype == 'python'
	call setline(1,"#!/usr/bin/env python")
	call append(line("."),"# coding=utf-8")
	call append(line(".")+1, "")
	" elseif &filetype == 'mkd'
	" " call setline(1,"<head><meta charset=\"UTF-8\"></head>")
    else
	 call setline(1, "/*************************************************************************")
	 call append(line("."), " > File Name: ".expand("%"))
	 call append(line(".")+1, " > Author:  何源川")
	 call append(line(".")+2, " > Mail: 249288984@qq.com ")
	 call append(line(".")+3, " > Created Time: ".strftime("%c"))
	 call append(line(".")+4, "**************************************************************************/")
	 call append(line(".")+5, "")
     endif
     if &filetype == 'cpp'
	 call append(line(".")+6, "#include<iostream>")
	 call append(line(".")+7, "using namespace std;")
	 call append(line(".")+8, "")
     endif
	 if &filetype == 'c'
	 call append(line(".")+6, "#include<stdio.h>")
	 call append(line(".")+7, "")
     endif
	 " if &filetype == 'java'
	 " call append(line(".")+6,"public class ".expand("%"))
	 " call append(line(".")+7,"")
	 " endif
	 "新建文件后，自动定位到文件末尾
 endfunc
 autocmd BufNewFile * normal G

"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
exec "w"
if &filetype == 'c'
	exec "!g++ % -o %<"
	exec "!time ./%<"
elseif &filetype == 'cpp'
	exec "!g++ % -o %<"
	exec "!time ./%<"
elseif &filetype == 'java'
	exec "!javac %"
	exec "!time java %<"
elseif &filetype == 'sh'
	:!time bash %
elseif &filetype == 'python'
	exec "!time python2.7 %"
elseif &filetype == 'html'
        exec "!firefox % &"
elseif &filetype == 'go'
        exec "!go build %<"
        exec "!time go run %"
elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
        endif
endfunc
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
        exec "w"
        exec "!g++ % -g -o %<"
        exec "!gdb ./%<"
endfunc



"don't bother with vi compatibility
set nocompatible

" enable syntax highlighting
"
syntax enable

" configure Vundle
filetype on " without this vim emits a zero exit status, later, because of :ft off
"filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" install Vundle bundles
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" ensure ftdetect et al work by including this after the Vundle stuff
filetype plugin indent on
