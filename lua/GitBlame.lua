local M = {}
local state = require("GitBlame.state")
local view = require("GitBlame.view")
local config_module = require("GitBlame.config")

---Setup the plugin
---@param user_config table
function M.setup(user_config)
	local augroup = vim.api.nvim_create_augroup("GitBlame", { clear = true })

	-- Export it
	M.config = config_module.setup(user_config)

	-- Allow disabling autocommands
	if M.config.enable_on_move then
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = M.blame,
			group = augroup,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			callback = M.clear,
			group = augroup,
		})
	end

	vim.api.nvim_set_hl(0, M.config.hl_group, M.config.hl)

	vim.api.nvim_create_user_command("GitBlameToggle", function()
		state.enabled = not state.enabled
		view.clear()
		vim.notify("Enabled: " .. tostring(state.enabled))
	end, { desc = "Toggle Git Blame" })
	vim.api.nvim_create_user_command("GitBlameEnable", function()
		state.enabled = true
		vim.notify("Enabled: " .. tostring(state.enabled))
	end, { desc = "Enable Git Blame" })
	vim.api.nvim_create_user_command("GitBlameDisable", function()
		state.enabled = false
		view.clear()
		vim.notify("Enabled: " .. tostring(state.enabled))
	end, { desc = "Disable Git Blame" })

	state.enabled = M.config.enabled
end

---Get blame for current line
---@param currFile string
---@param line number
---@return string
local function get_blame_line(currFile, line)
	local blame = vim.fn.system(string.format("git blame -c -L %d,%d %s", line, line, currFile))
	local hash = vim.split(blame, "%s")[1]

	local cmd = string.format("git show %s --format='%s'", hash, M.config.blame_format)

	if hash == "00000000" then
		return M.config.default_message
	else
		local out = vim.fn.system(cmd)
		local first_line = vim.split(out, "\n")[1]
		if first_line:find("fatal") then -- if the call to git show fails
			return M.config.default_message
		else
			return first_line
		end
	end
end

---show the blame for the current line
function M.blame()
	if not state.enabled then
		return
	end

	local ext = vim.fn.expand("%:h:t") -- get the current file extension
	if ext == "" or ext == "bin" then
		return -- we are in a scratch buffer, unknown filetype, or a terminal window
	end

	local currFile = vim.fn.expand("%")
	local line = vim.api.nvim_win_get_cursor(0)[1]
	local text = get_blame_line(currFile, line)

	view.show_virtual_text(line, text)
end
---Clear the current blame line
function M.clear()
	view.clear()
end

return M
