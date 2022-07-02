" it looks to have some bugs because mac OS cannot make a necessary file
" automatically. so we make it manually (2019/8/16). in the future, we have to
" solve this problem.
" https://hacknote.jp/archives/20740/. 
if has('win32')
  let cmd = 'tools\\update-dll-mingw'
elseif has('win32unix') " for Cygwin
  let cmd = 'make -f make_cygwin.mak'
elseif executable('gmake')
  let cmd = 'gmake'
else
  let cmd = 'make'
endif
let g:dein#plugin.build = cmd
