function! s:caniuse(input)
  let search_term = s:extract_search_term(a:input)

  if s:valid_search(search_term)
    call s:open_in_browser("http://caniuse.com/\\#search=" . search_term)
  end
endfunction

command! -nargs=1 Caniuse call s:caniuse(<f-args>)

" Input {{{
function! s:get_inner_word()
  let original_value = getreg('w', 1)
  let original_type = getregtype('w')
  let original_position = getpos('.')
  let original_isk = &isk

  setlocal isk+=-
  execute 'normal! "wyiw'
  let word = getreg()

  call setreg('w', original_value, original_type)
  call setpos('.', original_position)
  let &l:isk = original_isk

  return word
endfunction

function! s:get_visual_selection()
  " Thanks to xolox, http://stackoverflow.com/a/6271254/309160
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction
" }}}

" Validation {{{
function! s:extract_search_term(input)
  let search_term = a:input
  let css = matchlist(a:input, '\s*\(.\+\):.\+;')
  let html = matchlist(a:input, '<\/*\([A-z]*\)>')

  if len(css) > 0
    let search_term = css[1]
  elseif len(html) > 0
    let search_term = html[1]
  end

  return search_term
endfunction

function! s:valid_search(search)
  let unsuported_characters = match(a:search, '\n\|\s\|=\|?\|<\|>')

  if unsuported_characters != -1
    echoerr 'Unsuported characters received.'
    return 0
  elseif len(a:search) == 0
    echoerr 'No characters received.'
    return 0
  end

  return 1
endfunction
" }}}

" Browser methods {{{
function! s:get_browser_command()
  if exists("g:caniuse_browser_command")
    let open_command = g:caniuse_browser_command
  elseif has('win32') || has('win16')
    let open_command = 'start'
  else
    let os = substitute(system('uname'), "\n", "", "")

    if os == 'Darwin' || os == 'Mac'
      let open_command = 'open'
    elseif os =~ 'CYGWIN'
      let open_command = 'cygstart'
    elseif os == 'SunOS'
      let open_command = 'sdtwebclient'
    else
      let open_command = 'xdg-open'
    endif
  endif

  return open_command
endfunction

function! s:open_in_browser(url)
  call system(s:get_browser_command() . ' ' . a:url)
endfunction
" }}}

" Mappings {{{
function! s:caniuse_word()
  call s:caniuse(s:get_inner_word())
endfunction

function! s:caniuse_selection()
  call s:caniuse(s:get_visual_selection())
endfunction

nnoremap <silent> <Plug>Ncaniuse :<C-U>call <SID>caniuse_word()<CR>
vnoremap <silent> <Plug>Vcaniuse :<C-U>call <SID>caniuse_selection()<CR>

if !exists("g:caniuse_no_mappings") || ! g:caniuse_no_mappings
  nmap <leader>ciu <Plug>Ncaniuse
  vmap <leader>ciu <Plug>Vcaniuse
end
" }}}
