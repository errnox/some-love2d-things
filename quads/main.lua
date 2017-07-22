
function love.load()
  img = love.graphics.newImage('image.png')
  tl = love.graphics.newQuad(0, 0, 100, 100, img:getDimensions())
  tr = love.graphics.newQuad(100, 0, 100, 100, img:getDimensions())
  br = love.graphics.newQuad(100, 100, 100, 100, img:getDimensions())
  bl = love.graphics.newQuad(0, 100, 100, 100, img:getDimensions())
end

function love.update()
  
end

function love.draw()
  love.graphics.draw(img, tl, 0, 0+math.random(0, 5))
  love.graphics.draw(img, tr, 100+math.random(0, 5), 0)
  love.graphics.draw(img, br, 100, 100+math.random(0, 5))
  love.graphics.draw(img, bl, 0+math.random(0, 5), 100)
end
