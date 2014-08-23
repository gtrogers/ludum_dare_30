Drone = require('src.entities.drone')

local DroneSpawner = Thing.new()

function DroneSpawner:init(world)
    self.world = world
    self.drones = {}
end

function DroneSpawner:spawn(x, y, parent)
    if #self.drones < 5 then
        local drn = Drone(self.world, x, y)

        if parent then
            local vx, vy = parent:velocity()
            drn:inherit_velocity(vx, vy, parent:angle())
        end

        self.drones[#self.drones + 1] = drn
    end
end

function DroneSpawner:draw(g)
    for i, drn in ipairs(self.drones) do
        drn:draw(g)
    end
end

function DroneSpawner:update(dt)
    for i, drn in ipairs(self.drones) do
        drn:update(dt)
    end
end

return DroneSpawner

