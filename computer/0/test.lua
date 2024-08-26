local monitor = peripheral.find("monitor")
local button1 = {x1 = 3, y1 = 3, x2 = 11, y2 =5, label = "click", bg = "0", fg = "f"}
local button2 = {x1 = 23, y1 = 1, x2 = 23, y2 =1, label = "X", bg = "e", fg = "4"}
local button3 = {x1 = 26, y1 = 3, x2 = 34, y2 =5, label = "don't", bg = "0", fg = "f"}
local button4 = {x1 = 36, y1 = 1, x2 = 36, y2 =1, label = "X", bg = "e", fg = "4"}
local sw1 = {x1 = 3, y1 = 20, x2 = 11, y2 =22, label = "switch", bg = "8", fg = "f", active = false}
buttons1 = {button1, button2, sw1}
buttons2 = {button3, button4}
local frame1 = {x1 = 1, y1 = 1, x2 = 23, y2 = 10, label = "main", bg = "e", fg = "0", bgin= "4", buttons = buttons1}
local frame2 = {x1 = 24, y1 = 1, x2 = 36, y2 = 10, label = "dos", bg = "e", fg = "0", bgin= "4", buttons = buttons2}
frames = {frame1, frame2}

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
	monitor.setBackgroundColor(frame.bgin)
  monitor.setCursorPos(frame.x1, frame.y1)
	for i = frame.y1, frame.y2 do
		monitor.setCursorPos(frame.x1, i)
		monitor.write(string.rep(" ", frame.x2 - frame.x1 +1))
	end
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
	for i = 1, #frames do
		if frames[i] ~= nil then
			for u = 1, #frames[i]["buttons"] do
				local tx = x >= frames[i]["buttons"][u].x1 and x <= frames[i]["buttons"][u].x2
				local ty = y >= frames[i]["buttons"][u].y1 and y <= frames[i]["buttons"][u].y2
				if tx and ty then
					ret = {frame = i, button = frames[i]["buttons"][u], bin = u}
					return ret
				end
			end
		end
	end
  return nil
end

function waitForClick()
  while true do
		local frams = 0
		for i = 1, #frames do
			if frames[i] ~= nil then
				frams = frams + 1
			end
		end
		if frams == 0 then
			monitor.clear()
			break
		end
    local event, side, xPos, yPos = os.pullEvent("monitor_touch")
    local click = isInsideButton(xPos, yPos)
		if click ~= nil then
			if click.button.label == "switch" then
				if click.button.active then
					frames[click.frame]["buttons"][click.bin]["active"] = false
					frames[click.frame]["buttons"][click.bin]["bg"] = "8"
				else
					frames[click.frame]["buttons"][click.bin]["active"] = true
					frames[click.frame]["buttons"][click.bin]["bg"] = "5"
				end
				draw()
			end
    	if click.button.label == "click" then
				monitor.setTextColor(colors.white)
				monitor.setCursorPos(4, 7)
				monitor.write("chuj")
    	end
			if click.button.label == "don't" then
				monitor.setTextColor(colors.white)
				monitor.setCursorPos(4, 7)
				monitor.write("o ty chuju")
			end
			if click.button.label == "X" then
				frames[click.frame] = nil
				draw()
			end
    	if click.button.label == "exit" then
				monitor.clear()
    	  break
    	end
		end
  end
end

function draw()
	monitor.clear()
	for i=1, #frames do
		if frames[i] ~= nil then
	  	drawFrame(frames[i])
			for u=1, #frames[i]["buttons"] do
	  		drawButton(frames[i]["buttons"][u])
			end
		end
	end
	monitor.setBackgroundColor(colors.black)
end
draw()
waitForClick()
