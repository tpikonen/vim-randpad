# vim-randpad

This script implements vim commands `RandpadPad` and `RandpadRePad`.

`RandpadPad` inserts a long line containing random characters before the first
and last line of the buffer. The file is padded to a size which is multiple of
`g:RandPadBlocksize` (default 4096 bytes).

The length of the first random string is between 0.25 and 0.5 times
`g:RandPadBlocksize`. The second random string fills the buffer to a multiple
of the block size, but has a length of at least 0.125 times (1/8th of)
`g:RandPadBlocksize`.

`RandpadRePad` replaces an existing padding with new random strings.

Files which match `g:RandpadFilePattern` (which defaults to `*.rpad` and
`*.rp`) are automatically padded when created and re-padded when saving.

Random padding may be useful when storing encrypted files with small
incremental changes in content (e.g. lists of passwords) repeatedly to version
control.

For GnuPG encryption of files with vim, see
[vim-gnupg](https://github.com/jamessan/vim-gnupg).

## Installation

Just clone or copy to `~/.vim/pack/randpad/start/` on vim 8 or later, or use
your favorite
[plugin manager](https://github.com/mhinz/vim-galore#managing-plugins).

## License

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 3 of the License, or (at your option) any later
version. See https://www.gnu.org/licenses/.
