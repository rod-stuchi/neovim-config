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
