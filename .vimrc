"------------------基本配置------------------
set nocompatible

"开启文件类型检测
filetype on
"载入文件类型插件
filetype plugin on
"为特定文件载入相关缩进文件
filetype indent on

" 设置编码    
set encoding=utf-8    
set fenc=utf-8    
set fileencodings=ucs-bom,utf-8,cp936,gb2312,gb18030,big5   
   
"搜索忽略大小写 
set ignorecase
"命令行高度加1
set cmdheight=2 
                
"关闭提示音  
set vb t_vb=  
"忽略大小写的查找
set ignorecase　　
"设定文件浏览器目录为当前目录 
"set bsdir=buffer  
"set autochdir  
  
"保存100条命令历史记录  
set history=100

"高亮当前行
set cursorline 
"设置当文件被外部改变的时侯自动读入文件  
if exists("&autoread")  
    set autoread  
endif  


"设置制表符空格
set tabstop=4
set softtabstop=4
"缩进大小
set shiftwidth=4

"设置自动缩进：即每行的缩进值与上一行相等
set autoindent
set cindent

"------------------外观配置------------------
"显示行号  
set number
set relativenumber
"设置默认打开窗口大小  
set lines=60 columns=150  
  
"设置窗口透明度  
set transparency=0
  
"设置主题颜色  
colorscheme desert  
  
"隐藏工具栏和滑动条  
set guioptions=aAce      
            
"标签栏最多30个标签 ？ 
set tabpagemax=3

"总是显示标签栏    
set showtabline=2  

"总是在窗口右下角显示光标的位置  
set ruler     
      
"在Vim窗口右下角显示未完成的命令   
set showcmd   

"设置字体和大小
set guifont=Monaco:h15
   
"设置语法高亮 
syntax on  

"------------------快捷键配置------------------
"设置跳转到行尾快捷键映射
nnoremap - $ 
"正常模式下进入visual模式
nnoremap ] v


"------------------程序配置------------------
"括号自动补全
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {<CR>}<ESC>O
inoremap " ""<ESC>i
inoremap ' ''<ESC>i


"新建.cpp文件，自动插入文件头 
autocmd BufNewFile *.cpp exec ":call SetTitle()" 
func SetTitle()
	let l=1 | call setline(l, "/*************************************************************************")
    call append(line("."), "	> File Name: ".expand("%")) 
    call append(line(".")+1, "	> Author: xyue") 
    call append(line(".")+2, "	> Created Time: ".strftime("%c")) 
	let l=5 | call setline(l, "	> Problem: ") 
	let l=l+1 | call setline(l, "	> Analyse: ") 
	let l=l+1 | call setline(l, "*************************************************************************/") 
		if expand("%:e") == 'cpp'
			let l=l+1 | call setline(l,'#include <cstdio>')
			let l=l+1 | call setline(l,'#include <cstring>')
			let l=l+1 | call setline(l,'#include <iostream>')
			let l=l+1 | call setline(l,'#include <algorithm>')
			let l=l+1 | call setline(l,'#include <vector>')
			let l=l+1 | call setline(l,'#include <queue>')
			let l=l+1 | call setline(l,'#include <set>')
			let l=l+1 | call setline(l,'#include <map>')
			let l=l+1 | call setline(l,'#include <string>')
			let l=l+1 | call setline(l,'#include <cmath>')
			let l=l+1 | call setline(l,'#include <cstdlib>')
			let l=l+1 | call setline(l,'#include <ctime>')
			let l=l+1 | call setline(l,'#include <stack>')
			let l=l+1 | call setline(l,'using namespace std;')
			let l=l+1 | call setline(l,'typedef long long ll;')
			let l=l+1 | call setline(l,'typedef unsigned long long ull;')
			let l=l+1 | call setline(l,'typedef double db;')
			let l=l+1 | call setline(l,'#define mem(x,y) memset(x,y,sizeof(x))')
			let l=l+1 | call setline(l,'const db eps = 1e-7;')
			let l=l+1 | call setline(l,'const int MOD = 1e9+7;')
			let l=l+1 | call setline(l,'const int INF = 0x3f3f3f3f;')
			let l=l+1 | call setline(l,'const int MAXN = 1e3+10;')
			let l=l+1 | call setline(l,'const int MAXM = 1e4+10;')
			let l=l+1 | call setline(l,'')
			let l=l+1 | call setline(l,'int main(){')
			let l=l+1 | call setline(l,'    freopen("in.txt", "r", stdin);')
			let l=l+1 | call setline(l,'    //freopen("out.txt", "w", stdout);')
			let l+l+1 | call setline(l,'')
			let l=l+1 | call setline(l,'	return 0;')
			let l=l+1 | call setline(l,'}')
		endif
endfunc 

" F9 一键保存、编译、连接存并运行  
noremap <F9> :call  CompileAndRun()<CR>  
inoremap <F9> <ESC>:call CompileAndRun()<CR>  
   
"let s:linux_CFlags = 'gcc\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<'  
"let s:linux_CPPFlags = 'g++\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o:'  
let s:linux_CFlags = 'clang\ -w\ %\ -o\ %<'  
let s:linux_CPPFlags = 'clang++\ -w\ -std=c++11\ -stdlib=libc++\ %\ -o\ %<'  

func! CompileAndRun()
	exe ":ccl"
	exe ":update"
	if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
		let v:statusmsg = ''
		let v:errmsg= ''
		if expand("%:e") == "c"
			exe ":setlocal makeprg=".s:linux_CFlags
			silent make
		else
			exe ":setlocal makeprg=".s:linux_CPPFlags
			silent make
		endif
		redraw!  
		if empty(v:statusmsg)
			exe ":setlocal makeprg=./%<"
			silent make
			exe ": ! rm %:r"
			exe ":cope"
		
		else
			exe ":bo cope"
		endif
		
	endif
endfunc
 
 
 "------------------插件配置------------------
"ycm插件设置默认路径
let g:ycm_global_ycm_extra_conf = '/Users/xyue/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

 "设置插件管理
 set rtp+=~/.vim/bundle/vundle/  
 call vundle#rc()  
   
"这是vundle本身的设置  
 Bundle 'gmarik/vundle' 
 Bundle 'Valloric/YouCompleteMe'
 Bundle 'scrooloose/syntastic'
 Bundle 'scrooloose/nerdtree'
 Bundle 'bling/vim-airline'




"------------------YouCompleteMe------------------
" 跳转到定义处
nnoremap gd :YcmCompleter GoToDefinitionElseDeclaration<CR>

set completeopt=longest,menu

" 不显示开启vim时检查ycm_extra_conf文件的信息  
let g:ycm_confirm_extra_conf=0
" 输入第2个字符开始补全
let g:ycm_min_num_of_chars_for_completion=2
" 开启语义补全
let g:ycm_seed_identifiers_with_syntax=1	
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
" 设置在下面几种格式的文件上屏蔽ycm
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'nerdtree' : 1,
      \}


"------------------syntastic------------------
"set error or warning signs
let g:syntastic_error_symbol = '⚠'
let g:syntastic_warning_symbol = '⚠'

"whether to show balloons
let g:syntastic_enable_balloons = 1
"------------------nerdtree------------------

"------------------nerdtree------------------

