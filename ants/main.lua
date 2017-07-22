function love.load()
  win_w = love.graphics.getWidth()
  win_h = love.graphics.getHeight()

  points = {}
  for i = 0, 50, 1 do
    x = math.random(0, win_w)
    y = math.random(0, win_h)
    table.insert(points, {x = x, y = y, w = 10, h = 10, history = {}})
  end

  rand_move = 200

  love.graphics.setBackgroundColor(0, 0, 0)
end

function love.update(dt)
  for _, i in ipairs(points) do
    x = math.random(-rand_move, rand_move)
    y = math.random(-rand_move, rand_move)
    i.x = i.x + x * dt
    i.y = i.y + y * dt
    table.insert(i.history, 0, {x = i.x, y = i.y})
    if #i.history > 100 then
      table.remove(i.history)
    end
  end
end

function love.draw()
  for _, i in ipairs(points) do
    for _, h in ipairs(i.history) do
      love.graphics.setColor(100, 90, 80)
      love.graphics.circle('fill', h.x, h.y, 2)
    end
  end

  for _, i in ipairs(points) do
    love.graphics.setColor(200, 180, 160)
    love.graphics.circle('fill', i.x - i.w / 2, i.y - i.h / 2, i.w / 2)
  end
end
