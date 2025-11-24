---@diagnostic disable: undefined-global

local mod = 'SUPER'
hl.bind(mod .. ' + F', function()
  local windows = hl.get_windows()
  for _, window in ipairs(windows) do
    if window.title ~= nil then
      hl.dispatch(hl.dsp.exec_cmd('notify-send ' .. window.title))
    end
  end
end)

