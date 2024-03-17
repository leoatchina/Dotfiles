local wezterm = require 'wezterm'
local action = wezterm.action
local config = wezterm.config_builder()

config.term = ''
config.font_size = 10.5
config.keys = {
  {
    key = 'R',
    mods = 'CTRL|SHIFT|ALT',
    action = action.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  { key = 'n', mods = 'CTRL|SHIFT|ALT', action = action.MoveTabRelative(1) },
  { key = 'p', mods = 'CTRL|SHIFT|ALT', action = action.MoveTabRelative(-1) },
}

local os_name = os.getenv("OS")

if os_name == "Windows_NT" then
  config.default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe' }
end

return config
