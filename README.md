# git-blame.nvim

This project has been archived. Use f-person/git-blame.nvim instead. All major features are supported. The only unsupported feature is `prefix` and `left_padding`, but they can be made with `vim.g.gitblame_message_template`

Neovim plugin to show git blame on the current line using virtual text.
Not the first, not the last. I suggest you don't use this repo. Here's some alternatives:

- [git-blame.nvim (f-person)](https://github.com/f-person/git-blame.nvim)
- [git-blame-line.nvim (kessejones)](https://github.com/kessejones/git-blame-line.nvim)

If you _really_ want to use it, here's some docs:

Warning: Using this plugin on _large files_ can result in NeoVim freezing.

## Usage

```lua
require("git-blame").setup({
  -- Pass your options here - or don't
})
```

If `config.enable_on_move` is set to `true`, then autocomands will be created to show the blame on cursor move, otherwise, manage it yourself using `gitblame.blame()` (show the blame) and `gitblame.clear()` (remove the blame)

## Options and defaults:

```lua
  -- Passed to git --pretty=format
  blame_format = "%an | %ar | %s",
  -- Highlight group for the output virtual text
  hl_group = "GitBlame",
  -- Highlight to apply to the output virtual text
  hl = { link = "Comment" },
  -- Whether to update on cursor move
  enable_on_move = true,
  -- String to show before the blame
  prefix = "",
  -- How many spaces to place before the blame
  left_padding = 1,
  -- Message to display if the line hasn't been committed yet
  default_message = "No commit",
  -- Whether to enable when setup called. Can be disabled
  -- with :GitBlameDisable
  enabled = true,
```

## Commands

- :GitBlameDisable
- :GitBlameEnable
- :GitBlameToggle

## Thanks:

- Initial git blame code: [Taylor Thompson](https://teukka.tech/vimtip-gitlens.html)
- Initial view code: [kessejones](https://github.com/kessejones/git-blame-line.nvim/blob/main/lua/git-blame-line/view.lua)
- Inspiration: [f-person](https://github.com/f-person/git-blame.nvim)

## Todo (if I have time):

- `gitblame_delay` option, defaults to `500`. This should help with flickering.
- `ft_ignore` option, array of file type to disable on. default to something reasonable (man, term, etc).
