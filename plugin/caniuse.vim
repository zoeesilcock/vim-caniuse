function! s:get_inner_word()
  let original_value = getreg('w', 1)
  let original_type = getregtype('w')
  let original_position = 0

  execute 'normal! "wyiw'
  let word = getreg()

  call setreg('w', original_value, original_type)

  return word
endfunction

function! s:open_in_browser(url)
  call system('open ' . a:url)
endfunction

function! s:caniuse()
  let search = s:get_inner_word()

  call s:open_in_browser("http://caniuse.com/\\#search=" . search)
endfunction
command! Caniuse call s:caniuse()
