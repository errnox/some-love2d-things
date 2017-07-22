local Boid = require 'boid'


function love.load()
  boids = {}
  win_width, win_height = love.graphics.getDimensions()
  for i=0, 30, 1 do
    x, y = math.random(0, win_width), math.random(0, win_height)
    boid = Boid:new(x, y)
    -- boid:track_mouse()
    boid:orient_randomly()
    table.insert(boids, boid)
  end

  boid = Boid:new(150, 200)

  scale_x, scale_y = 1.0, 1.0
  paused = false

  win_w, win_h = love.graphics.getDimensions()
end

function love.update(dt)
  if not paused then
    boid:update(dt)

    for _, boid in ipairs(boids) do
      boid:update(dt)
    end
  end
end

function love.draw()
  love.graphics.push()
  love.graphics.scale(scale_x, scale_y)

  love.graphics.setColor(48, 58, 68)
  love.graphics.rectangle('fill', 0, 0, win_w, win_h)

  boid:draw()

  for _, boid in ipairs(boids) do
    boid:draw()
  end

  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle('fill', 100, 100, 50, 50)

  love.graphics.pop()

  if paused then
    love.graphics.print('Lost Focus', 10, 10, 0, 4, 4)
  end
end

function love.keypressed(key)
  if key == 'i' then
    scale_x = scale_x + 0.1
    scale_y = scale_y + 0.1
  elseif key == 'o' then
    scale_x = scale_x - 0.1
    scale_y = scale_y - 0.1
  end
end

function love.focus(f)
  paused = not f
end
