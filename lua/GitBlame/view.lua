local config = require("GitBlame.config")
local state = require("GitBlame.state")
local M = {}

---Pads the blame string according to the config
---@param text string
---@return string
local function pad_left(text)
  local conf = config.get_config()
  local pre = conf.prefix
  local pad = conf.left_padding
  return string.format("%s%s%s", string.rep(" ", pad), pre, text)
end

---Creates options object for buf_set_extmark
---@param text string
---@return table
function M.create_ext_mark_opts(text)
  local opts = vim.tbl_deep_extend("force", {
    virt_text_pos = "eol",
    hl_mode = "combine",
  }, config.get_config().set_extmark_opts or {})

  -- force this
  opts.virt_text = {
    { pad_left(text), config.get_config().hl_group },
  }

  return opts
end

---Show virtual {text} on {line}
---@param line number
---@param text string
function M.show_virtual_text(line, text)
  local opts = M.create_ext_mark_opts(text)
  vim.api.nvim_buf_set_extmark(0, state.ns_id, line - 1, 0, opts)
end

---Clears the namespace, and thus the shown virtual text
function M.clear()
  vim.api.nvim_buf_clear_namespace(0, state.ns_id, 0, -1)
end

return M
