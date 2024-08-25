local monitor = peripheral.find("monitor")
local button1 = {x1 = 3, y1 = 3, x2 = 11, y2 =5, label = "click", bg = "0", fg = "f"}
local button2 = {x1 = 23, y1 = 1, x2 = 23, y2 =1, label = "X", bg = "e", fg = "4"}
buttons = {button1, button2}
local frame1 = {x1 = 1, y1 = 1, x2 = 23, y2 = 10, label = "main", bg = "e", fg = "0"}
frames = {frame1}

function drawButton(button)
  monitor.setBackgroundColor(colors.fromBlit(button.bg))
  monitor.setTextColor(colors.fromBlit(button.fg))
  monitor.setCursorPos(button.x1, button.y1)
  for i = button.y1, button.y2 do
    monitor.setCursorPos(button.x1, i)
    monitor.write(string.rep(" ", button.x2 - button.x1 + 1))
  end
  local tx = button.x1 +2 >= button.x2
  local ty = button.y1 +1 >= button.y2 
	if tx and ty then
		monitor.setCursorPos(button.x1, button.y1)
		monitor.write(button.label)
	else
  	monitor.setCursorPos(button.x1 +2, button.y1 +1)
    monitor.write(button.label)
	end
end

function drawFrame(frame)
  monitor.setBackgroundColor(colors.fromBlit(frame.bg))
  monitor.setTextColor(colors.fromBlit(frame.fg))
  monitor.setCursorPos(frame.x1, frame.y1)
	for i = frame.x1, frame.x2 do
		monitor.setCursorPos(i, frame.y1)
		monitor.write("=")
		monitor.setCursorPos(i, frame.y2)
		monitor.write("=")
		monitor.setCursorPos(i, frame.y2)
	end
  for i = frame.y1, frame.y2 do
    monitor.setCursorPos(frame.x1, i)
    monitor.write("|")
    monitor.setCursorPos(frame.x2, i)
    monitor.write("|")
  end
  monitor.setCursorPos(frame.x1 +1, frame.y1)
  monitor.write(frame.label)
end

function isInsideButton(x,y)
  for i = 1, #buttons do
    local tx = x >= buttons[i].x1 and x <= buttons[i].x2
    local ty = y >= buttons[i].y1 and y <= buttons[i].y2
    if tx and ty then
      return buttons[i].label
    end
  end
  return "null"
end

function waitForClick()
  while true do
    local event, side, xPos, yPos = os.pullEvent("monitor_touch")
    local click = isInsideButton(xPos, yPos)
    if click == "click" then
			monitor.setTextColor(colors.white)
			monitor.setCursorPos(4, 7)
			monitor.write("chuj")
    end
    if click == "X" then
			monitor.clear()
      break
    end
  end
end

monitor.clear()
for i=1, #frames do
  drawFrame(frames[i])
end
for i=1, #buttons do
  drawButton(buttons[i])
end
monitor.setBackgroundColor(colors.black)
waitForClick()
