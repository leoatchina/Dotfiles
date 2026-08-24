local wezterm = require 'wezterm'
local action = wezterm.action
local config = wezterm.config_builder()

config.term = "xterm-256color"
config.font_size = 10.5

-- 在 WezTerm 配置中添加新的键绑定
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
  { key = 'Enter', mods = 'ALT', action = action.DisableDefaultAssignment },
  -- Encode Alt chords as CSI-u Alt+character events. Uppercase payloads omit
  -- Shift so both Herdr and tmux see M-<uppercase>.
  { key = "'", mods = 'ALT|SHIFT', action = action.SendString '\x1b[27;3;34~' },
  { key = 'o', mods = 'ALT|SHIFT', action = action.SendString '\x1b[27;3;79~' },
  { key = 'o', mods = 'ALT', action = action.SendString '\x1b[111;3u' },
  { key = 'h', mods = 'ALT|SHIFT', action = action.SendString '\x1b[72;3u' },
  { key = 'j', mods = 'ALT|SHIFT', action = action.SendString '\x1b[74;3u' },
  { key = 'k', mods = 'ALT|SHIFT', action = action.SendString '\x1b[75;3u' },
  { key = 'l', mods = 'ALT|SHIFT', action = action.SendString '\x1b[76;3u' },
  { key = 'p', mods = 'ALT|SHIFT', action = action.SendString '\x1b[80;3u' },
  { key = 'n', mods = 'ALT|SHIFT', action = action.SendString '\x1b[78;3u' },
  { key = '[', mods = 'ALT', action = action.SendString '\x1b[91;3u' },
  { key = ']', mods = 'ALT', action = action.SendString '\x1b[93;3u' },
  { key = '\\', mods = 'ALT|SHIFT', action = action.SendString '\x1b[124;3u' },
  { key = '\\', mods = 'ALT',       action = action.SendString '\x1b[92;3u' },
}

for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL|SHIFT|ALT',
    action = action.ActivateTab(i - 1),
  })
end

local os_name = os.getenv("OS")
if os_name == "Windows_NT" then
  -- Use pwsh if available in PATH, otherwise fallback to powershell.exe
  config.default_prog = { 'C:/Program Files/PowerShell/7/pwsh.exe' }
  config.set_environment_variables = {
    LESS = "-R",
  }
  table.insert(config.keys, {
    key = "S",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SpawnCommandInNewTab{
      args = {"powershell.exe", "-NoExit", "-Command", [[
        $hosts = Get-Content $HOME\.ssh\config | Where-Object { $_ -match "^Host\s+" } | ForEach-Object { $_.Split()[1] };
        $selectedHost = $hosts | Out-GridView -Title "选择一个主机进行SSH连接" -PassThru;
        if ($selectedHost) {
          ssh $selectedHost
        } else {
          Write-Host "没有选择主机";
          exit;
        }
      ]]},
    },
  })
end

return config
