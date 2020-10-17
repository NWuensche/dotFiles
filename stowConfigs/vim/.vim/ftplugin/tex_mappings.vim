"called when pressing <C-x><C-u>
"actual function in .vim/autoload/
setlocal completefunc=latexcomplete#CompleteFA
"imap $ n
" <expr> allows evaluate function afterwards
inoremap <expr> $ AddTildesBeforeDollarR()
"use this with keys and not <expr> because with <expr> I can't do setlist ("normal r4") (only way to change characters in vimscript), get error -> use keys like a
"inoremap stops $-call recursion hell
"Always see call in status bar, this flickering is annoying
"inoremap $ <Esc>:call AddTildesBeforeDollar()<CR>a$
"Need this because leader="," and if I write ,$ to fast it thinks it is <leader>$ shortcut
"inoremap stops $-call recursion hell
inoremap <leader>$ , $

function! AddTildesBeforeDollarR()
  let keysReturn = ""
  "get position of cursor on line to know what is left of cursor
  let start = col('.') - 1
  "1-x negates x
  "if cursor on left, then do nothing special
  if 1-IsInsideMathEnvironment() && (start>0)
    "INFO a + b, a+=b is always number evaluation, returns 0 for two strings
    let keysReturn = keysReturn . "\<ESC>"
    let keysReturn = keysReturn . ChangeSpaceR()
    let keysReturn = keysReturn . "a"
  endif
  let keysReturn = keysReturn . '$'
  return keysReturn
endfun

"Change previous symbol in line if necessary
"Does check for comma (no tilde), space(replace with tilde), {}(replace with tilde) and any other symbol(add tilde if no space-thing before)
function! ChangeSpaceR()
  " get current line (all of it)
  let line = getline('.')
  "get position of cursor on line to know what is left of cursor
  "INFO Yes,  in <expr> expression -2 instead of -1 (normal)
  let start = col('.') - 2
  "if on , then write space and $ later
  if line[start] == ','
    return " "
  endif
  "normal behavior for $$ symbol
  if line[start] == '$'
    return ""
  endif

  "Check for symbol before cursor
  if start>0
    "if command \test{}, then {} is space -> replace {} with ~
    if line[start] == '}' && line[start-1] == '{'
      return "xr~"
    endif
    if line[start-1] != ',' && line[start] == ' '
      return "r~"
    endif
    if line[start-1] == ',' && line[start] == ' '
      return ""
    endif
  endif

  "replace space with tilde
  if line[start] == ' '
    return "r~"
  endif
  "on something that is not space, -> dd a 
  if line[start] != ' '
    return "a~\<ESC>"
  endif
endfun

function! AddTildesBeforeDollar()
  "get position of cursor on line to know what is left of cursor
  let start = col('.') - 1
  let line = getline('.')
  "1-x negates x
  "if cursor on left, then do nothing special
  if 1-IsInsideMathEnvironment() && (start>0)
    call ChangeSpace()
    "line[start-1] = 'i'
    "return '$'
    return ''
  endif
endfun

"Change previous symbol in line if necessary
"Does check for comma (no tilde), space(replace with tilde), {}(replace with tilde) and any other symbol(add tilde if no space-thing before)
function! ChangeSpace()
  " get current line (all of it)
  let line = getline('.')
  "get position of cursor on line to know what is left of cursor
  let start = col('.') - 1
  "if on , then write space and $ later
  if line[start] == ','
    normal a 
    return ''
  endif

  "Check for symbol before cursor
  if start>0
    "if command \test{}, then {} is space -> replace {} with ~
    if line[start] == '}' && line[start-1] == '{'
      normal xr~
      return ''
    endif
    if line[start-1] != ',' && line[start] == ' '
      "Does press r and ~, without normal would do :r~<CR>
      normal r~
      return ''
    endif
    if line[start-1] == ',' && line[start] == ' '
      return ''
    endif
  endif

  "replace space with tilde
  if line[start] == ' '
    normal r~
    return ''
  endif
  "on something that is not space, -> dd a 
  if line[start] != ' '
    normal a~
    return ''
  endif
endfun

"Say I'm inside math mode if number of $ before cursor is odd (works also when
"$$-environment somewhere
"returns 1 if in math mode, 0 else
function! IsInsideMathEnvironment()
  " get current line (all of it)
  let line = getline('.')
  "get position of cursor on line to know what is left of cursor
  let start = col('.') - 1
  "Go to left of line, count $ lines
  let numDollarsLeft = 0
  while start >= 0
    if line[start] == "$"
      let numDollarsLeft += 1
    endif
    let start -= 1
"        while start > 0 && (line[start - 1] =~ '\a' || line[start - 1] =~ '.' || line[start - 1] =~ '-')
  endwhile
  return numDollarsLeft % 2
endfun
