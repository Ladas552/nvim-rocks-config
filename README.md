# What is this?
It is my neovim config using lua. Conventional way, instead of using [nixvim](https://github.com/nix-community/nixvim) or [nvf](https://github.com/NotAShelf/nvf)

It is based on Neovim-nightly

# Why?
I want to try new things, I got pretty confident with Lua, getting to work it out on NixOS too

# How to use on NixOS?
You can look in my NixOS config for [Neovim module](https://github.com/Ladas552/Nix-Is-Unbreakable/blob/master/homeModules/neovim/default.nix). It contains the override and some packages to make my config work

It adds override, and also uses home-manager to create synlinks for reproducable rebuilds.

`meta.isTermux` is my custom attribute used in NixOS, just delete it and use package list as normal

# TODO
[Norg treesitter parser](https://github.com/nvim-neorg/tree-sitter-norg) parser doesn't work. So no Neorg for now

[image.nvim](https://github.com/3rd/image.nvim) can't find magick implementation, so no images in terminal

[typst-previewer.nvim](https://github.com/chomosuke/typst-preview.nvim) can't open the web based preview, so I got a self made autocmd for typst

# Credits

I am not the one to write most of this

### Override was taken from:
[NTBBloodbath](https://github.com/NTBBloodbath/tundra/blob/master/nixos/modules/system/editor.nix) editor module, which was based on [Benlubas neovim flake](https://github.com/benlubas/.dotfiles/blob/main/nvim/flake.nix)

### Config is based on:

NTBBloodbath's [neovim config](https://github.com/NTBBloodbath/nvim), defaults are his.

Rishabh's [neovim config](https://github.com/Rishabh672003/Neovim), for all the nightly goodies


