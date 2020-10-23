" Gets called when doing <C-x><C-u> (Have to set function in appropriate ftplugin/ file
" Gets called two times. 
" First time with findstart=1 and base = 0, expects left position to check against completion (right position is always current cursor postion
" Second time findstart = 0, base = marked substring start-currentPos, expects " list of possible strings to replace base with 
" TODO Can even return more information for each item (e.g. Theorem explanation
" More info: :h completefunc
function! latexcomplete#CompleteFA(findstart, base)
    " for first call, find left position
    if a:findstart
        " locate the start of the word
        let line = getline('.')
        "start left from cursor
        "TODO What if cursor on {?
        let start = col('.') - 1
        "As long as no '{' visited, go left
        while start > 0 && (line[start - 1] != '{')
            let start -= 1
"        while start > 0 && (line[start - 1] =~ '\a' || line[start - 1] =~ '.' || line[start - 1] =~ '-')
        endwhile

        " If at start of line (and first letter not a {) -> not inside a bracket =>
        " return -3 (== no completion appicable, leave completion menu)
        " TODO Also check inside cref or cite/citet (get string until cursor, ends with cref...?
        if start != 0
          "Am I inside a cref/citet/cite bracket -> else, return -3 again
          let prefixBracket = latexcomplete#getPrefixBracket()
          "Valid calls, else not (-3)
          if (prefixBracket == 'cref') || (prefixBracket == 'citet') || (prefixBracket == 'cite')
            return start
          endif
        endif
        return -3

        " return left possible to mark and replace

    " for second call, return list of words to replace base with
    else
        let outLabels = []
        "a:base == argument with the name base
        "echoerr allLabels
        "echoerr a:base
        let weg = latexcomplete#getCitetLabels()

        " Check which labels are applicable (by prefix)
        let prefixBracket = latexcomplete#getPrefixBracket()
        "Checked in first call that valid call (either cref/citet/cite), now do different things regarding to call
        let allLabels = []
        if (prefixBracket == 'cref')
          let allLabels = latexcomplete#getCrefLabels()
        " is citet/cite
        else
          let allLabels = latexcomplete#getCitetLabels()
        endif
        for label in allLabels
          "label starts with current marked (base) string -> Add label to list
          if label =~ '^' . a:base 
            call add(outLabels, label)
          endif
        endfor

        "echo does not print (or at least no stop for reading) , echoerr does!
        "echoerr 'oh it failed'

        " return list with all applicable labels (what ever applicable means)
        return outLabels
    endif
endfun

"Already know that left of cursor is a bracket {
"returns prefix between this bracket and '\'
"This means for '\NAME{tt' returns NAME (Cursor on t)
"or empty if no name (e.g. '{te' , 'noBackSlash{t'
function! latexcomplete#getPrefixBracket()
        let line = getline('.')
        let cursor = col('.') - 1
        let labelContent = matchstr(line, '\\label{\zs[^}]*\ze}')
        "current line text including char under cursor
        "let leftTillCursor = split(getline('.')[:col('.')]-1)[0]
        "get everything left of cursor
        let leftTillCursor = line[0:cursor-1]
        "echoerr 'a' .leftTillCursor
        "This means for '\NAME{tt' returns NAME (Cursor on t)
        "Is greedy, so returns LAST bracket name (which is good, because closest bracket to cursor
        let bracketName = matchstr(leftTillCursor, '.*\\\zs[^{]*\ze{')
        "echoerr 'b' .bracketName

        return bracketName
endfunction

"return list of all contents of \label{CONTENT} (important for cref)
function! latexcomplete#getCrefLabels()
  "returns list with all lines (don't have to save file before, just returns current buffer
  let lines = getline(1,'$')

  "list of all contents of \label{CONTENT}
  "Assume at most one label per line
  let labels = [] 
  for line in lines
    "returns CONTENT inside \label{CONTENT}
    "\zs is start of which part of matchstr should be returned, \ze is end
    "(otherwise \label{CONTENT} would be returned)
    let labelContent = matchstr(line, '\\label{\zs[^}]*\ze}')

    "empty returns 0 if empty, else 1
    "as vim does not seems to have a not operator, do 1-x to negate
    if 1-empty(labelContent) 
      call add(labels, labelContent)
    endif
  endfor
  return labels
endfun

"return list of all contents of @X{CONTENT, (important for citet/cite)
function! latexcomplete#getCitetLabels()
  "returns list with all lines (don't have to save file before, just returns current buffer
  "returns list of lines in bibfile
  "expands does expand the ~ to home folder
  let lines = readfile(expand('~/Dokumente/Master_Berlin/5.Semester/master-niklas-wuensche/thesis/bibfile.bib'))

  "list of all contents of @X{CONTENT,
  "Assume at most one label per line
  let labels = [] 
  for line in lines
    "returns CONTENT inside \X{CONTENT,
    "\zs is start of which part of matchstr should be returned, \ze is end
    "(otherwise \X{CONTENT, would be returned)
    let labelContent = matchstr(line, '@[^{]*{\zs[^ ,}]*\ze[ ,}]*')

    "empty returns 0 if empty, else 1
    "as vim does not seems to have a not operator, do 1-x to negate
    if 1-empty(labelContent) 
      call add(labels, labelContent)
    endif
  endfor
  return labels
endfun
