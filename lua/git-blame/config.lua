local M = {}

local default_config = {
  blame_format = "%an | %ar | %s",
  hl_group = "GitBlame",
  hl = { link = "Comment" },
  enable_on_move = true,
  prefix = "",
  left_padding = 1,
  default_message = "No commit",
  enabled = true,
}

local config = {}
---create config using defualt config
---@param user_config table
---@return table
function M.setup(user_config)
  config = vim.tbl_deep_extend("force", default_config, user_config or {})
  return config
end

---Returns reference to current configuration
---@return table
function M.get_config()
  return config
end

return M
