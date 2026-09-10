local get_cwd = ya.sync(function() return tostring(cx.active.current.cwd) end)

local function url_decode(s)
    s = s:gsub("+", " ")
    s = s:gsub("%%(%x%x)", function(h) return string.char(tonumber(h, 16)) end)
    return s
end

return {
    entry = function()
        local text = ya.clipboard()
        if not text or text == "" then return end

        local cwd = get_cwd()
        local last_path = nil

        for line in text:gmatch("[^\r\n]+") do
            local path = line
            if path:match("^file://") then
                path = url_decode(path:sub(8))
            end

            local src = io.open(path, "rb")
            if src then
                local content = src:read("*a")
                src:close()

                local name = path:match("([^/]+)$") or "pasted_file"
                local dest = io.open(cwd .. "/" .. name, "wb")
                if dest then
                    dest:write(content)
                    dest:close()
                    last_path = cwd .. "/" .. name
                end
            end
        end

        if last_path then
            ya.emit("reveal", { last_path })
        end
    end,
}
