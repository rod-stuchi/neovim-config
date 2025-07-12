vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.tabstop = 2
vim.wo.foldlevel = 99

vim.cmd([[
iab clg console.log("")<Left><Left>
iab clge console.error()<Left>
]])

-- Create or clear the autocommand group to avoid duplication
vim.api.nvim_create_augroup("AutoFmtOnSave", { clear = true })

-- Check if `npm run format` is available in the package.json scripts
local function has_npm_format()
	local handle = io.popen("npx prettier -v")
	if handle then
		local result = handle:read("*a")
		handle:close()
		-- Check for any version number (e.g., 3.3.3) to confirm prettier is installed
		return result:find("%d+%.%d+%.%d+") ~= nil
	else
		return false
	end
end

-- Autocommand to run on save (:w) for TypeScript files
vim.api.nvim_create_autocmd("BufWritePost", {
	group = "AutoFmtOnSave",
	pattern = "*.ts,*.tsx,*.js,*.jsx",
	callback = function()
		if has_npm_format() then
			-- If npm format is available, run it asynchronously and silently
			vim.fn.jobstart("npx prettier -w " .. vim.fn.expand("%"), {
				stdout_buffered = true, -- Optional: Buffer stdout so we can handle the output
				stderr_buffered = true,

				-- Callback for what to do when the job finishes
				on_exit = function(_, exit_code)
					if exit_code == 0 then
						vim.notify("🦇 File formatted successfully!", vim.log.levels.INFO)
						-- Reload the buffer with changes
						vim.cmd("checktime") -- Use 'checktime' to refresh the file without losing unsaved buffer changes
					else
						vim.notify("🙈 Failed to format file.", vim.log.levels.ERROR)
					end
				end,
			})
		else
			-- Optional: Print a message if the format command is not found
			vim.notify("'🙈 npx prettier' command not found", vim.log.levels.ERROR)
		end
	end,
})
