M = {}


Player = {}

function Player:new(x, y)
  local obj = {
    x = x,
    y = y,
    s = 100,
    a = 3,
    w = 100,
    h = 50,
  }
  self.__index = self
  return setmetatable(obj, self)
end

function Player:move_around(dt)
  self.x = self.x + self.s * dt
  if self.x >= love.graphics.getWidth() - self.w then
    self.s = -self.s
  elseif self.x < 0 then
    self.s = -self.s
  end
end

function Player:update(dt)
  self:move_around(dt)

  if love.keyboard.isDown("down") then
    self.y = self.y + self.s * self.a * dt
  end

  if love.keyboard.isDown("up") then
    self.y = self.y - self.s * self.a * dt
  end

  if love.keyboard.isDown("left") then
    self.x = self.x - self.s * self.a * dt
  end

  if love.keyboard.isDown("right") then
    self.x = self.x + self.s * self.a * dt
  end
end

function Player:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
  love.graphics.print(string.format("x=%i\ny=%i", self.x, self.y),
                      self.x, self.y)
  love.graphics.draw(img, self.x, self.y, 0, 2, 2)
end


M = Player

return M
