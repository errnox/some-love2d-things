local Player = require 'player'



function love.mousepressed(x, y, button)
  if button == 'l' then
    local r = math.random(0, 255)
    local g = math.random(0, 255)
    local b = math.random(0, 255)
    table.insert(circles, {x=love.mouse.getX(), y=love.mouse.getY(),
                           color={r=r, g=g, b=b}})
  end
end

function draw_circles()
  for _, c in ipairs(circles) do
    love.graphics.setColor(c.color.r, c.color.g, c.color.b)
    love.graphics.circle('fill', c.x, c.y, 20)
  end
end

function love.load()
  player = Player:new(50, 100)

  rectangles = {}
  table.insert(rectangles, {x = 10, y = 20})
  table.insert(rectangles, {x = 15, y = 35})
  table.insert(rectangles, {x = 100, y = 40})
  table.insert(rectangles, {x = 200, y = 220})

  circles = {}

  img = love.graphics.newImage('img/smiley.png')

  love.mouse.setPosition(
    love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)

  is_fullscreen = false
end

function love.update(dt)
  player:update(dt)

  if love.keyboard.isDown('j') then
    table.insert(rectangles,
                 {x = math.random(0, love.graphics.getWidth()),
                  y = math.random(0, love.graphics.getHeight())})
  end
end

function love.draw()
  love.graphics.print("Hello World!", 100, 100)
  love.graphics.circle("fill", 10, 10, 10, 10)

  for _, rect in ipairs(rectangles) do
    local r = math.random(0, 255)
    local g = math.random(0, 255)
    local b = math.random(0, 255)
    love.graphics.setColor(r, g, b)
    love.graphics.rectangle('fill', rect.x, rect.y, 10, 10)
    love.graphics.setColor(180, 40, 40)
    love.graphics.circle("fill", love.graphics.getWidth() / 2 - 50,
                         love.graphics.getHeight() / 2 - 50 ,20)
  end

  draw_circles()

  player:draw(love)

  love.graphics.draw(
    img, love.graphics.getWidth() / 2 - img:getWidth() / 2,
    love.graphics.getHeight() / 2 - img:getHeight() / 2)

end

function love.keypressed(key)
  if key == 'x' then
    table.insert(rectangles,
                 {x = math.random(0, love.graphics.getWidth()),
                  y = math.random(0, love.graphics.getHeight())})
  elseif key == 'q' then
    os.exit()
  elseif key == 'l' then
    love.load()
  elseif key == 'f' then
    is_fullscreen = not is_fullscreen
    love.window.setFullscreen(is_fullscreen)
  end
end
