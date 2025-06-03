
local defaults = {
	commands = {},
	add_binding = "<C-a>",
	delete_binding = "<C-d>",
}

local M = {
	term_bufnr = nil,
	term_winid = nil,
	job_running = false,

	commands = {},

	config = defaults
}

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", defaults, opts or {})
	M.commands = M.config.commands;
end

local function scroll_to_bottom()
  local info = vim.api.nvim_get_mode()
  if info and (info.mode == "n" or info.mode == "nt") then vim.cmd("normal! G") end
end

function M.run_command(cmd)
	if M.job_running then
		vim.notify("A command is already running.", vim.log.levels.ERROR)
		return
	end

	-- Handle overwrite of old buffer if necessary
	if not vim.api.nvim_buf_is_valid(M.term_bufnr or -1) then
		M.term_bufnr = vim.api.nvim_create_buf(false, true)
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = M.term_bufnr, silent = true })

		-- Reuse the split or open a new one
		if not vim.api.nvim_win_is_valid(M.term_winid or -1) then
			M.term_winid = vim.api.nvim_open_win(M.term_bufnr, true, {split = "right", width = 80})
			vim.api.nvim_set_current_win(M.term_winid)
			scroll_to_bottom()
		else
			vim.api.nvim_set_current_win(M.term_winid)
			vim.api.nvim_win_set_buf(M.term_winid, M.term_bufnr)
			scroll_to_bottom()
		end
	else
		local old_buf = M.term_bufnr
		M.term_bufnr = vim.api.nvim_create_buf(false, true)
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = M.term_bufnr, silent = true })

		-- Reuse the split or open a new one
		if not vim.api.nvim_win_is_valid(M.term_winid or -1) then
			M.term_winid = vim.api.nvim_open_win(M.term_bufnr, true, {split = "right"})
			vim.api.nvim_set_current_win(M.term_winid)
			scroll_to_bottom()
		else
			vim.api.nvim_set_current_win(M.term_winid)
			vim.api.nvim_win_set_buf(M.term_winid, M.term_bufnr)
			scroll_to_bottom()
		end

		vim.cmd.bdelete(old_buf)
	end

	vim.cmd.startinsert()

	-- Start terminal job
	vim.fn.jobstart(cmd, {
		term = true,
		pty = true,
		width = 80,
		on_exit = function()
			M.job_running = false
			-- vim.notify("Command finished: " .. cmd, vim.log.levels.INFO)
		end,
	})

	M.job_running = true
end

function M.add_command(command)
	if type(command) == "string" then
		table.insert(M.commands, command)
	else
		error("Command must be a string")
	end
end

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
function M.picker(opts)
	opts = opts or require("telescope.themes").get_dropdown()
	pickers.new(opts, {
		prompt_title = "run command",
		finder = finders.new_table {
			results = M.commands
		},
		sorter = conf.generic_sorter(opts),
		attach_mappings = function (prompt_bufnr, map)
			actions.select_default:replace(function ()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				M.run_command(selection[1])
			end)

			-- Add a new command to the list
			map({"i", "n"}, M.config.add_binding, function()
				local picker = action_state.get_current_picker(prompt_bufnr)

				vim.ui.input({ prompt = "New: ", completion = "shellcmdline" }, function(input)
					vim.cmd [[ redraw ]]
					M.add_command(input)
					local finder = finders.new_table{
						results = M.commands
					}
					picker:refresh(finder, { reset_prompt = true })
				end)
			end)

			-- Remove a command from the list
			map({"i", "n"}, M.config.delete_binding, function()
				local picker = action_state.get_current_picker(prompt_bufnr)
				local selection = action_state.get_selected_entry()

				table.remove(M.commands, selection.index)

				local finder = finders.new_table{
					results = M.commands
				}
				picker:refresh(finder, { reset_prompt = true })
			end)
			return true
		end,
	}):find()
end

-- Example usage: prompt user for command and run it
vim.api.nvim_create_user_command("RunCommand", function()
	M.picker()
end, {})

return M
