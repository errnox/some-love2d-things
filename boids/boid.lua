M = {}


Boid = {}

function Boid:new(x, y)
  local o = {
    x = x, y = y,
    color = {r = 200, g = 40, b = 60},
    t = 10,
    angle = 0,
    s = 100,
    is_tracking_mouse = false
  }
  self.__index = self
  return setmetatable(o, self)
end

function Boid:update(dt)
  -- self.angle = self.angle + 0.3 * dt
  if self.is_tracking_mouse == true then
    local mouse_x, mouse_y = love.mouse.getPosition()
    local cos = math.cos(self.angle)
    local sin = math.sin(self.angle)

    self.angle = math.atan2(mouse_y - self.y, mouse_x - self.x)

    self.x = self.x + self.s * cos * dt
    self.y = self.y + self.s * sin * dt
    

    local buffer = 100
    if math.abs(mouse_x - self.x) < buffer and
    math.abs(mouse_y - self.y) < buffer then
      self.x = self.x - self.s * cos * dt
      self.y = self.y - self.s * sin * dt
    end
  end

  self:wander(dt)
  self:wrap_screen()
end

function Boid:draw()
  love.graphics.push()
  love.graphics.translate(self.x, self.y)
  love.graphics.rotate(self.angle)
  love.graphics.translate(-self.x, -self.y)

  love.graphics.setColor(self.color.r, self.color.g, self.color.b)
  love.graphics.polygon(
    'fill',
    self.x-self.t, self.y-self.t,
    self.x+self.t+self.t/2, self.y,
    self.x-self.t, self.y+self.t
  )

  love.graphics.setColor(255, 255, 0)
  love.graphics.circle('fill', self.x, self.y, 1)

  love.graphics.pop()
end

function Boid:track_mouse()
  self.is_tracking_mouse = true
end

function Boid:wrap_screen()
  w, h = love.graphics.getDimensions()
  if self.x > w then self.x = 2 end
  if self.x < 0 then self.x = w-2 end
  if self.y > h then self.y = 3 end
  if self.y < 0 then self.y = h-2 end
end

function Boid:orient(boids, dt)
  local sin, cos = 0
  local buffer = 30

  local n_locals = #boids/4
  local scan_zone = 100
  local avg_angle = self.angle
  local sum_angles = 0
  local local_neighbors = {}
  for _, boid in pairs(boids) do
    -- Avoid collision with local boids.
    if math.abs(boid.x - self.x) < buffer or
    math.abs(boid.y - self.y) < buffer then
      self.angle = -math.atan2(boid.y - self.y, boid.x - self.x)
    end

    -- Steer towards average heading of local boids.
    --
    -- if math.abs(boid.x - self.x) < scan_zone or
    -- math.abs(boid.y - self.y) < scan_zone then
    --   if #local_neighbors >= n_locals then
    --     table.remove(local_neighbors, #local_neighbors)
    --   end
    --   table.insert(local_neighbors, boid)

    --   for _, i in ipairs(local_neighbors) do
    --     sum_angles = sum_angles + i.angle
    --   end
    --   avg_angle = sum_angles / n_locals
    --   self.angle = avg_angl
    -- end
  end
end

function Boid:orient_randomly()
  self.angle = math.random(0, 2 * math.pi)
end


function Boid:wander(dt)
  local cos = math.cos(self.angle)
  local sin = math.sin(self.angle)

  self.x = self.x + self.s * cos * dt
  self.y = self.y + self.s * sin * dt

  self:orient(boids, dt)
end


M = Boid

return M
