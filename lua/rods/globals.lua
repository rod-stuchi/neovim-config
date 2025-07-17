P = function(v)
	print(vim.inspect(v))
	return v
end

Debugprint_toggle_JSON = function()
	if vim.g.DEBUGPRINT_JSON_ENABLED == nil then
		vim.g.DEBUGPRINT_JSON_ENABLED = false
	end
	vim.g.DEBUGPRINT_JSON_ENABLED = not vim.g.DEBUGPRINT_JSON_ENABLED
	print("JSON Debugprint Toggled: " .. tostring(vim.g.DEBUGPRINT_JSON_ENABLED))
end

Has_value = function(tab, val)
	for _, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

Scandir = function(regex, directory)
	local i, t, popen = 0, {}, io.popen
	local pfile = popen("fd " .. regex .. " --full-path " .. directory)
	if pfile ~= nil then
		for filename in pfile:lines() do
			i = i + 1
			t[i] = filename
		end
		pfile:close()
	end
	return t
end

Get_emoji = function(show_emoji_name, repeatN)
	local handle = io.popen("python ~/.scripts/emoji/choice.py")
	local result = ""
	if handle ~= nil then
		result = handle:read("*a")
		handle:close()
	end

	result = result:gsub("\n", "")
	local symbol, text = string.match(result, "(.*)#(.*)")
	repeatN = repeatN or 3 -- default to 3 if not provided
	if show_emoji_name then
		return string.rep(symbol, repeatN) .. " " .. text
	else
		return string.rep(symbol, repeatN) .. " "
	end
end
