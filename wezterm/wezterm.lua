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
  config.default_prog = { 'pwsh.exe' }
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