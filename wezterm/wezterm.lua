local wezterm = require 'wezterm'
local action = wezterm.action
local config = wezterm.config_builder()

config.term = ''
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
}


config.default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe' }

return config

