local get_paths = ya.sync(function()
    local tab, paths = cx.active, {}
    for _, u in pairs(tab.selected) do
        paths[#paths + 1] = tostring(u)
    end
    if #paths == 0 and tab.current.hovered then
        paths[1] = tostring(tab.current.hovered.url)
    end
    return paths
end)

return {
    entry = function()
        local paths = get_paths()
        if #paths == 0 then return end

        local lines = {}
        for _, p in ipairs(paths) do
            lines[#lines + 1] = "file://" .. p
        end
        local data = table.concat(lines, "\n") .. "\n"

        local tmp = "/tmp/yazi-sys-copy.txt"
        local ok, err = fs.write(Url(tmp), data)
        if not ok then
            ya.notify { title = "Copy", content = "Failed to write temp file: " .. tostring(err), timeout = 3 }
            return
        end

        local tool = os.getenv("WAYLAND_DISPLAY")
            and "wl-copy --type text/uri-list < " .. tmp
            or "xclip -selection clipboard -t text/uri-list < " .. tmp

        local child, spawn_err = Command("sh"):arg("-c"):arg(tool):spawn()
        if not child then
            ya.notify { title = "Copy", content = "Failed to spawn shell: " .. tostring(spawn_err), timeout = 3 }
            return
        end
        child:wait()

        ya.notify { title = "Copy", content = "Copied file(s) to clipboard", timeout = 2 }
    end,
}
