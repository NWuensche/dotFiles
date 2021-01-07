"en is both us + gb english
"en_us/en_gb are seperate languages
"For MA is consistency only en_us nice + "graph coloring" in american english seems to be used more than "graph colouring" (KKS20 uses coloring)
setlocal spelllang=en_us,de
"else syntax highlighting fails
set redrawtime=10000

"Fixes that syntax is not applied sometimes, but takes some time
syntax sync fromstart

"called when pressing <C-x><C-u>
"actual function in .vim/autoload/
setlocal completefunc=latexcomplete#CompleteFA

"Normal syn regions/matchs don't seem to work because there already is this tex.vim file where I have to plug in, I can't just do whatever I want
"Don't spellcheck argument of cref anymore - This is adapted from /usr/share/vim/vim82/syntax/tex.vim Line 649 (Add new keyword "cref" that behaves like bibliography/label..., which is what I want)
syn region texRefZone		matchgroup=texStatement start="\\cref{"		end="}\|%stopzone\>"	contains=@texRefGroup
"syn region texRefZone		matchgroup=texStatement start="\\draw\[" end=";\|%stopzone\>"	contains=@texRefGroup,@NoSpell
"syn region myTikzR start='\[' end=']' contains=Delimeter,@NoSpell,@texMatchGroup
"syn region myTikzR start='\[' end=']' contains=@NoSpell
"syn region myTikzRA start='(' end=')' contains=@NoSpell
"syn keyword myTikzK ]

"syn region texRefZone		matchgroup=texStatement start="\\draw" end=";\|%stopzone\>"	contains=myTikzR,myTikzRA
"syn region texRefZone		matchgroup=texStatement start="\\node" end=";\|%stopzone\>"
"syn region my	start="\\draw" end=";"
"hi def link my Todo
"syn region texRefZone		matchgroup=texStatement start="\\tikzstyle{"		end="}\|%stopzone\>" contains=@texRefGroup
"Spell check optional argument of \cite(t) because e.g. could misspell "Theorem" or "Corollary" - Override/Copy /usr/share/vim/vim82/syntax/tex.vim Line 653, only changed to add @Spell option to get spellchecking for this optional argument of \cite(t)
"syn region texRefOption	contained	matchgroup=Delimiter start='\[' end=']'		contains=@texRefGroup,texRefZone,@Spell	nextgroup=texRefOption,texCite

"syn region myTikz	start="\\node" 		end=";\|%stopzone\>"	contains=myTikzR
"syn region myTikzR start='(' end=')' contains=@NoSpell


"Don't increase numbers accidentally when using tmux
nnoremap <C-a> <nop>

"Don't insert strange stuff accidentally when using tmux
inoremap <C-a> <nop>
"imap $ n
" <expr> allows evaluate function afterwards
inoremap <expr> $ AddTildesBeforeDollar()
"use this with keys and not <expr> because with <expr> I can't do setlist ("normal r4") (only way to change characters in vimscript), get error -> use keys like a
"inoremap stops $-call recursion hell
"Always see call in status bar, this flickering is annoying
"inoremap $ <Esc>:call AddTildesBeforeDollar()<CR>a$
"Need this because leader="," and if I write ,$ to fast it thinks it is <leader>$ shortcut
"inoremap stops $-call recursion hell
inoremap <leader>$ , $

"Use Custom Method for folding
set foldmethod=expr
"Use this custom folding (have to give it parameter v:lnum, does not work
"somehow to get inside the function
"INFO If I want to change actual folding displayed text: https://stackoverflow.com/questions/33281187/how-to-change-the-way-that-vim-display-those-collapsed-folded-lines
set foldexpr=MyLatexFold(v:lnum)


function! AddTildesBeforeDollar()
  let keysReturn = ""
  "get position of cursor on line to know what is left of cursor
  let start = col('.') - 1
  "1-x negates x
  "if cursor on left, then do nothing special
  if 1-IsInsideMathEnvironment() && (start>0)
    "INFO a + b, a+=b is always number evaluation, returns 0 for two strings
    let keysReturn = keysReturn . "\<ESC>"
    let keysReturn = keysReturn . ChangeSpace()
    let keysReturn = keysReturn . "a"
  endif
  let keysReturn = keysReturn . '$'
  return keysReturn
endfun

"Change previous symbol in line if necessary
"Does check for comma (no tilde), space(replace with tilde), {}(replace with tilde) and any other symbol(add tilde if no space-thing before)
function! ChangeSpace()
  " get current line (all of it)
  let line = getline('.')
  "get position of cursor on line to know what is left of cursor
  "INFO Yes,  in <expr> expression -2 instead of -1 (normal)
  let start = col('.') - 2
  "if on , then write space and $ later
  if line[start] == ','
    return " "
  endif

  "Else double tilde
  if line[start] == '~'
    return ""
  endif
  "normal behavior for $$ symbol
  if line[start] == '$'
    return ""
  endif
  "normal behavior for e.g. \emph{!$
  if line[start] == '{'
    return ""
  endif

  "Check for 1 symbol before cursor
  if start>0
    "Check for 2 symbols before cursor
    "if command '\test{} ', then '{} ' is space -> replace '{} ' with ~
    if start>1
      if line[start] == ' ' && line[start-1] == '}' && line[start-2] == '{'
        "small x jumps cursor to right, capital X jumps cursor to left
        return "XXr~" 
      endif
    endif
    "if command '\test{}', then '{}' is space -> replace '{}' with ~
    if line[start] == '}' && line[start-1] == '{'
      return "Xr~"
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

" Fold all documentsclass/chapter/section/subsection/subsubsection on some level (else too hard to find anything) + all figures
" INFO More sophisticated fold start/ends mechanisms: :help fold-expr
function! MyLatexFold(currLineNum)
  "Line starts with (spaces ok) a keywork
  "Block for chapter/section/... indentation
  let regex = '^\s*\\\(documentclass\|chapter\|section\|subsection\|subsubsection\|paragraph\)'
  let line = getline(a:currLineNum)
  if line =~ regex
      " A level 1 fold starts here
      " INFO Only have level 1 folds here (everything on same level
      return '>1'
  else
    let lastLineNum = line('$')
    "If not at last line (else error)
    "Check if next line contains keyword
    "If so, end folding here(cause on next line starts new one)
    if a:currLineNum != lastLineNum
      let nextLine = getline(a:currLineNum + 1)
      "Check if next line contains keyword
      if nextLine =~ regex
        "End level 1 fold
        return '<1'
      endif
  endif

    "Block for figures
    if line =~ '^\s*\\begin{figure}'
      "add one indent level
      return 'a1'
    elseif line =~ '^\s*\\end{figure}'
      "subtract one indent level
      return 's1'
    endif

    " Use fold level from previous line
    return '='

  endif
endfunction
