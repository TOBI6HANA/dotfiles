---------------------
---- SCREENSHOTS ----
---------------------

-- Dependencies: hyprshot, swappy, wl-clipboard
-- Screenshots are saved to ~/Screenshots/ with a timestamp filename
-- and automatically copied to clipboard after capture.
--
-- Keybinds:
--   Print                    → fullscreen
--   SUPER + Print            → region
--   SUPER + SHIFT + Print    → window
--
--   ALT + Print              → fullscreen → edit in swappy → clipboard
--   SUPER + ALT + Print      → region    → edit in swappy → clipboard
--   SUPER + SHIFT + ALT + Print → window → edit in swappy → clipboard

local mainMod = "SUPER"
local dir     = "~/Screenshots"
local tmp     = "/tmp/hs_tmp.png"

-- Take screenshot, save with timestamp, copy to clipboard
-- (hyprshot copies to clipboard by default)
local function shot(mode)
    return ('mkdir -p ' .. dir .. ' && hyprshot -m ' .. mode ..
            ' --output-folder ' .. dir ..
            ' --filename "$(date +%Y-%m-%d_%H-%M-%S).png"')
end

-- Take screenshot, open in swappy for annotation, save with timestamp, copy edited result to clipboard
local function shot_edit(mode)
    return ('mkdir -p ' .. dir .. '; ' ..
            'hyprshot -m ' .. mode .. ' --output-folder /tmp --filename hs_tmp.png; ' ..
            'f="' .. dir .. '/$(date +%Y-%m-%d_%H-%M-%S).png"; ' ..
            'swappy -f ' .. tmp .. ' -o "$f"; ' ..
            'wl-copy < "$f"')
end


-- Capture only
hl.bind("Print",                                    hl.dsp.exec_cmd(shot("output")))
hl.bind(mainMod .. " + Print",                      hl.dsp.exec_cmd(shot("region")))
hl.bind(mainMod .. " + SHIFT + Print",              hl.dsp.exec_cmd(shot("window")))

-- Capture → edit in swappy → save → clipboard
hl.bind("ALT + Print",                              hl.dsp.exec_cmd(shot_edit("output")))
hl.bind(mainMod .. " + ALT + Print",                hl.dsp.exec_cmd(shot_edit("region")))
hl.bind(mainMod .. " + SHIFT + ALT + Print",        hl.dsp.exec_cmd(shot_edit("window")))
