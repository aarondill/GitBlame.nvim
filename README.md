# GitBlame.nvim

Not the first, not the last. I suggest you don't use this repo. Here's some alternatives:
https://github.com/f-person/git-blame.nvim
https://github.com/kessejones/git-blame-line.nvim

If you _really_ want to use it, here's some docs:

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
  -- How many spaces to place before the blameit
  left_padding = 1,
  -- Message to display if the line hasn't been committed yet
  default_message = "No commit",
  -- Whether to enable when setup called. Can be disabled
  -- with :GitBlameDisable
  enabled = true,
```

## commands

- :GitBlameDisable
- :GitBlameEnable
- :GitBlameToggle
