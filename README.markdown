caniuse.vim
===========

This plugin allows you to perform searches on caniuse.com directly from vim.

Usage
-----

You can trigger a search from normal mode in which case it will pick the word
under the cursor or you can trigger it from visual mode which will search for
the selection.

The built in mapping is:
```
leader ciu
```

You can also use command mode:
```
:Caniuse border-radius
```

Mappings
--------------

You can disable this mapping by setting adding this to your .vimrc:
```
let g:caniuse_no_mappings = 1
```

If you want to setup your own key mappings use the following:

Mapping        | Description
---------------|-------------------------------------------------
<Plug>Ncaniuse | For normal mode (uses the word under the cursor)
<Plug>VCaniuse | For visual mode (uses the selection)

For example:
```
:nmap <leader>foo <Plug>Ncaniuse
:vmap <leader>foo <Plug>Vcaniuse
```

Note: Using :noremap will not work with <Plug> mappings.
