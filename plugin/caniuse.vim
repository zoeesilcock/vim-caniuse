function! s:get_inner_word()
  let original_value = getreg('w', 1)
  let original_type = getregtype('w')
  let original_position = 0

  execute 'normal! "wyiw'
  let word = getreg()

  call setreg('w', original_value, original_type)

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

function! s:open_in_browser(url)
  call system('open ' . a:url)
endfunction

function! s:caniuse(search)
  call s:open_in_browser("http://caniuse.com/\\#search=" . a:search)
endfunction

function! s:caniuse_word()
  call s:caniuse(s:get_inner_word())
endfunction

function! s:caniuse_selection()
  call s:caniuse(s:get_inner_selection())
endfunction

command! -nargs=1 Caniuse call s:caniuse(<f-args>)

nnoremap <silent> <Plug>Ncaniuse :<C-U>call <SID>caniuse_word()<CR>
vnoremap <silent> <Plug>Vcaniuse :<C-U>call <SID>caniuse_selection()<CR>

if !exists("g:caniuse_no_mappings") || ! g:caniuse_no_mappings
  nnoremap <leader>ciu <Plug>Ncaniuse
  vnoremap <leader>ciu <Plug>Vcaniuse
end
