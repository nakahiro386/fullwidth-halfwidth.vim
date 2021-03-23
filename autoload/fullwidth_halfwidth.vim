"=============================================================================
" File: fullwidth-halfwidth.vim
" Author: nakahiro386
" Created: 2021-03-20
"=============================================================================

scriptencoding utf-8

if !exists('g:loaded_fullwidth_halfwidth')
    finish
endif
let g:loaded_fullwidth_halfwidth = 1

let s:save_cpo = &cpo
set cpo&vim

let s:half_ascii_min_nr = char2nr(' ', 1)
let s:half_ascii_max_nr = char2nr('~', 1)

let s:full_ascii_min_nr = char2nr('！', 1)
let s:full_ascii_max_nr = char2nr('～', 1)

let s:offset = char2nr('！', 1) - char2nr('!', 1)

function! fullwidth_halfwidth#toFullwidthAscii(word) abort
  let l:ret = ""
  for l:c in split(a:word, '\zs')
    if l:c ==# ' '
      let l:ret .= '　'
    elseif l:c ==# '"'
      let l:ret .= '”'
    elseif l:c ==# "'"
      let l:ret .= '’'
    elseif l:c ==# '`'
      let l:ret .= '｀'
    else
      let l:nr = char2nr(l:c, 1)
      if s:half_ascii_min_nr <= l:nr && l:nr <= s:half_ascii_max_nr
        let l:ret .= nr2char(l:nr + s:offset, 1)
      else
        let l:ret .= l:c
      endif
    endif
  endfor
  return l:ret
endfunction

function! fullwidth_halfwidth#toHalfwidthAscii(word) abort
  let l:ret = ""
  for l:c in split(a:word, '\zs')
    if l:c ==# '　'
      let l:ret .= ' '
    elseif l:c ==# '”'
      let l:ret .= '"'
    elseif l:c ==# '’'
      let l:ret .= "'"
    elseif l:c ==# '‘'
      let l:ret .= '`'
    else
      let l:nr = char2nr(l:c, 1)
      if s:full_ascii_min_nr <= l:nr && l:nr <= s:full_ascii_max_nr
        let l:ret .= nr2char(l:nr - s:offset, 1)
      else
        let l:ret .= l:c
      endif
    endif
  endfor
  return l:ret
endfunction

function! fullwidth_halfwidth#convertRange(mode) range abort
  let l:lnum = a:firstline
  while l:lnum <= a:lastline
    call setline(l:lnum, fullwidth_halfwidth#to{a:mode}(getline(l:lnum)))
    let l:lnum += 1
  endwhile
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
