local monitor = peripheral.find("monitor")
monitor.setBackgroundColor(colors.black)
monitor.clear()
local curve = {
	{"x", "x", "x"},
	{"x", " ", "x"},
	{"x", " ", "x"},
}
local curve3 = {
	{"x", "x", "x"},
	{" ", " ", "x"},
	{"x", "x", "x"},
}
local curve2 = {
	{"x", " ", "x"},
	{"x", " ", "x"},
	{"x", "x", "x"},
}
local curve4 = {
	{"x", "x", "x"},
	{"x", " ", " "},
	{"x", "x", "x"},
}
monitor.setBackgroundColor(colors.white)
monitor.setCursorPos(1,1)
local endx = 0
local endy = 0
local la = 0
local lb = 0
function cur(curve)
	for a = 1, #curve do
		for b = 1, #curve[a] do
			if curve[a][b] == "x" then
				monitor.setCursorPos(endx+b, endy+a)
				monitor.write(" ")
				lb = b
				la = a
			end
		end
	end
end
for i = 1, #curve do
	cur(curve)
	endy = endy + la
	endx = endx + lb
	cur(curve2)
	endy = endy + la
	endx = endx + lb
	cur(curve3)
	endy = endy + la
	endx = endx + lb
	cur(curve4)
	endx = endx + lb
	endy = endy + la
end
