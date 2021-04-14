local value = 0
local font = {value = love.graphics.newFont("PT_Sans/PTSans-Bold.ttf", 45), result = love.graphics.newFont("PT_Sans/PTSans-Bold.ttf", 25)}
local result = {}
local i = 1

function love.load()
	--[[Creates Australian-English translations of the colour functions]]
  love.graphics.getBackgroundColour = love.graphics.getBackgroundColor
  love.graphics.getColour           = love.graphics.getColor
  love.graphics.getColourMask       = love.graphics.getColorMask
  love.graphics.getColourMode       = love.graphics.getColorMode
  love.graphics.setBackgroundColour = love.graphics.setBackgroundColor
  love.graphics.setColour           = love.graphics.setColor
  love.graphics.setColourMask       = love.graphics.setColorMask
  love.graphics.setColourMode       = love.graphics.setColorMode
end

function love.update()
	if value > 0 then
		if value % i == 0 then
			result[#result+1] = {i, value/i}
		end
		i = i + 1
	end
	
end

function love.draw()
	love.graphics.setColour(0.1,0.1,0.1)
	love.graphics.rectangle("fill", 0, 0, 800, 200)
	love.graphics.setFont(font.value)
	love.graphics.setColour(value,value,value)
	love.graphics.print(value, 50, 50)

	love.graphics.setFont(font.result)
	for j=1, #result do
		local y = j*30-30
		love.graphics.print(result[j][1] .. " x " .. result[j][2], 50, y + 220)
		--love.graphics.print(varToString(result[j]), 50, 220+y)
	end
	--love.graphics.print(varToString(result), 50, 220)

	love.graphics.rectangle("fill", 0,590, i/value*800, 10)
end

function love.keypressed(k)
	result = {}
	i = 1
	if k =="backspace" then
		value = math.floor(value/10)
	else
		value = value*10 + k
	end
end

function varToString(var) -- thank you so much HugoBDesigner! (https://love2d.org/forums/viewtopic.php?t=82877)
  if type(var) == "string" then
    return "\"" .. var .. "\""
  elseif type(var) ~= "table" then
    return tostring(var)
  else
    local ret = "{"
    local ts = {}
    local ti = {}
    for i, v in pairs(var) do
      if type(i) == "string" then
        table.insert(ts, i)
      else
        table.insert(ti, i)
      end
    end
    table.sort(ti)
    table.sort(ts)
    
    local comma = ""
    if #ti >= 1 then
      for i, v in ipairs(ti) do
        ret = ret .. comma .. varToString(var[v])
        comma = ", "
      end
    end
    
    if #ts >= 1 then
      for i, v in ipairs(ts) do
        ret = ret .. comma .. "" .. v .. " = " .. varToString(var[v])
        comma = ", \n"
      end
    end
    
    return ret .. "}"
  end
end
