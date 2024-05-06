local wezterm = require 'wezterm'
local action = wezterm.action
local config = wezterm.config_builder()

config.term = ''
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
  config.default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe' }
  config.set_environment_variables = {
    LESS = "-R",
  }
end


-- 解析 ~/.ssh/config 文件并生成 SSH IP 列表
local function get_ssh_ips()
  local ips = {}
  local file = io.open(os.getenv("HOME") .. "/.ssh/config", "r")
  if file then
    for line in file:lines() do
      local ip = line:match("HostName%s+(%S+)")
      if ip then
        table.insert(ips, ip)
      end
    end
    file:close()
  end
  return ips
end

-- 创建一个新的动作，该动作将显示一个包含所有 SSH IP 的菜单
local function ssh_menu()
  local menu_items = {}
  local ssh_ips = get_ssh_ips()
  for _, ip in ipairs(ssh_ips) do
    table.insert(menu_items, {
      label = ip,
      action = wezterm.action({SpawnCommandInNewTab = {"ssh", ip}})
    })
  end
  return menu_items
end

-- 在 WezTerm 配置中添加新的动作
wezterm.on("show_ssh_menu", function(window, pane)
  window:show_menu(ssh_menu())
end)

table.insert(config.keys, {
  key="s",
  mods="CTRL|SHIFT",
  action=wezterm.action_callback(
    function()
      wezterm.show_quick_select(ssh_menu())
    end
  )
})


return config
