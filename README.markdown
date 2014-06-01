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
--------

You can disable this mapping by setting adding this to your .vimrc:
```
let g:caniuse_no_mappings = 1
```

If you want to setup your own key mappings use the following:

Mapping              | Description
---------------------|-------------------------------------------------
```<Plug>Ncaniuse``` | For normal mode (uses the word under the cursor)
```<Plug>Vcaniuse``` | For visual mode (uses the selection)

For example:
```
:nmap <leader>foo <Plug>Ncaniuse
:vmap <leader>foo <Plug>Vcaniuse
```

Note: Using :noremap will not work with <Plug> mappings.

Requirements
------------

The plugin should work out of the box on most systems, but opening a URL in
your web browser requires an external program. The plugin will do it's
best to find the built in command on your system. On Linux it assumes that you
have xdg-open which is installed by default on most distributions (it's part of
the xdg-utils package in case you happen to not have it).

If the plugin fails to find the right command or you want to use another
one you can specify the command in your .vimrc file:
```
  let g:caniuse_browser_command = 'open'
```

The command you put here will be called with the URL as a parameter.
