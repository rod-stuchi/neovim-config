P = function(v)
	print(vim.inspect(v))
	return v
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

Get_emoji = function(show_emoji_name)
	local handle = io.popen("python ~/.scripts/emoji/choice.py")
	local result = ""
	if handle ~= nil then
		result = handle:read("*a")
		handle:close()
	end

	result = result:gsub("\n", "")
	local symbol, text = string.match(result, "(.*)#(.*)")
	if show_emoji_name then
		return string.rep(symbol, 3) .. " " .. text
	else
		return string.rep(symbol, 3) .. " "
	end
end
