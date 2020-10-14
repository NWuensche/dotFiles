"called when pressing <C-x><C-u>
"actual function in .vim/autoload/
setlocal completefunc=latexcomplete#CompleteFA
"imap $ n
" <expr> allows evaluate function afterwards
"imap <expr> $ My_mapping()
"use this with keys and not <expr> because with <expr> I can't do setlist (only way to change characters in vimscript), get error -> use keys like a
"inoremap stops $-call recursion hell
inoremap $ <Esc>:call AddTildesBeforeDollar()<CR>a$
"Need this because leader="," and if I write ,$ to fast it thinks it is <leader>$ shortcut
"inoremap stops $-call recursion hell
inoremap <leader>$ , $

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
    if line[start-1] != ',' && line[start] == ''
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
