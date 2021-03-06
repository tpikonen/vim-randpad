" Name:    autoload/randpad.vim
" Last Change: 2020-11-26
" Original Author:  Teemu Ikonen <tpikonen@gmail.com>
" Summary: Vim plugin for adding random character padding to a file.
" License: This program is free software: you can redistribute it and/or
"          modify it under the terms of the GNU General Public License as
"          published by the Free Software Foundation, either version 3 of
"          the License, or (at your option) any later version.
"          See <https://www.gnu.org/licenses/>.

" Section: Constants {{{1

if (!exists("g:RandpadBlocksize"))
  let g:RandPadBlocksize=4096
endif
let s:maxStartPad=g:RandPadBlocksize/2
let s:minStartPad=g:RandPadBlocksize/4
let s:minEndPad=g:RandPadBlocksize/8

" Section: Functions {{{1

" Function: randpad#pad() {{{2
"
" Add random padding to the beginning and end of the buffer.
"
function randpad#pad()
  execute "normal! ggO"
  execute "normal! Go"
  execute "normal! k"
  call s:RandpadReplacePadding()
endfunction

" Function: randpad#repad() {{{2
"
" Check if the beginning and end of buffer have something looking like
" random padding and if so, replace it by new padding.
"
function randpad#repad()
  let startlen = strlen(getline(1))
  let endlen = strlen(getline(line('$')))
  if (startlen < s:minStartPad || startlen > s:maxStartPad
    \ || match(getline(1), " ") > 0)
    echohl WarningMsg
    let dump = input("Padding not found at the beginning of file. (Press ENTER)")
    echohl None
    return
  endif
  if (endlen < s:minEndPad || match(getline(line('$')), " ") > 0)
    echohl WarningMsg
    let dump = input("Padding not found at the end of file. (Press ENTER)")
    echohl None
    return
  endif
  call s:RandpadReplacePadding()
endfunction

" Function: s:RandpadReplacePadding() {{{2
"
" Replace the first and last lines of the buffer with a random string.
" The string lenghts are such that the file length will become approximately
" a multiple of blocksize, 4096 bytes.
"
function s:RandpadReplacePadding()
  let blocksize = g:RandPadBlocksize
  let random = system('bash -c "echo -n $RANDOM"')
  let maxran = 32767 " Maximum value of $RANDOM from bash
  let lennewline = 0
  if &fileformat == 'dos'
    let lennewline = 1
  endif

  let curline=line('.')
  execute 'set nofoldenable'
  let startjunklen=s:minStartPad+((s:maxStartPad - s:minStartPad)*random)/maxran
  execute '1!head -c'.startjunklen.' /dev/urandom | base64 | tr --delete ''\n='' | head -c '.startjunklen
  let nowlen=line2byte('$')
  let endjunklen=blocksize*(1+(nowlen+s:minEndPad+lennewline)/blocksize)-nowlen-lennewline
  execute '$!head -c'.endjunklen.' /dev/urandom | base64 | tr --delete ''\n='' | head -c '.endjunklen
  execute 'set foldenable'
  execute curline
endfunction

" vim600: set foldmethod=marker foldlevel=0 :
