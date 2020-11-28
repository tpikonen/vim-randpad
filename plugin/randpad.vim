" Name:    plugin/randpad.vim
" Last Change: 2020-11-26
" Original Author:  Teemu Ikonen <tpikonen@gmail.com>
" Summary: Vim plugin for adding random character padding to a file.
" License: This program is free software: you can redistribute it and/or
"          modify it under the terms of the GNU General Public License as
"          published by the Free Software Foundation, either version 3 of
"          the License, or (at your option) any later version.
"          See <https://www.gnu.org/licenses/>.

" Section: Plugin header {{{1

" guard against multiple loads {{{2
if (exists("g:loaded_randpad") || &cp || exists("#Randpad"))
  finish
endif
let g:loaded_randpad = '0.1.0'

" check for correct vim version {{{2
if (v:version < 702)
  echohl ErrorMsg | echo 'plugin randpad.vim requires Vim version >= 7.2' | echohl None
  finish
endif

" Section: Autocmd setup {{{1

if (!exists("g:RandpadFilePattern"))
  let g:RandpadFilePattern = '*.{rpad,rp}'
endif

augroup Randpad
  autocmd!

  exe "autocmd BufNewFile " . g:RandpadFilePattern .
                                                \ " call randpad#pad()"

  exe "autocmd BufWritePre,FileWritePre " . g:RandpadFilePattern .
                                                \ " call randpad#repad()"

augroup END

" Section: Commands {{{1

command! RandpadPad call randpad#pad()
command! RandpadRePad call randpad#repad()

" vim600: set foldmethod=marker foldlevel=0 :
