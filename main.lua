require('src.loader') 

local AsteroidSpawner = require('src.spawners.asteroid_spawner')
local ColonyShip = require('src.entities.colony_ship')
local DroneSpawner = require('src.spawners.drone_spawner')

local last_click = {0,0}

local rot = 0
local ship_rot_speed = 0.05

function love.load()
    world = require('src.physics')
    asteroid_spawner = AsteroidSpawner(world)
    drone_spawner = DroneSpawner(world)
    colony_ship = ColonyShip(world, love.window.getWidth()/2, love.window.getHeight()*0.6)

    layers = {
        {
            z=1, draw=function(g)
                asteroid_spawner:draw(g)
                colony_ship:draw(g)
                drone_spawner:draw(g)
            end
        }
    }
end

function love.update(dt)
    world:update(dt)
    asteroid_spawner:spawn()
    asteroid_spawner:update(dt)
    drone_spawner:update(dt)
    colony_ship:update(dt, rot)

    if love.keyboard.isDown("left") then rot = rot - ship_rot_speed*dt end
    if love.keyboard.isDown("right") then rot = rot + ship_rot_speed*dt end

    local dx, dy = colony_ship:world_coords()

    if love.keyboard.isDown(" ") then drone_spawner:spawn(dx+64,dy, colony_ship) end
end

function love.draw()
    for i, l in ipairs(layers) do
        love.graphics.push()
            local x, y = colony_ship:world_coords()
            local screen_x = x - love.window.getWidth()/2
            local screen_y = y - love.window.getHeight()*0.6
            love.graphics.translate(x, y)
            love.graphics.translate(-x-screen_x, -y - screen_y)
            l.draw(love.graphics)
            love.graphics.point(unpack(last_click))
        love.graphics.pop()
        
        love.graphics.push()
            love.graphics.print("Angle: " .. colony_ship:angle(), 8, 8)
            love.graphics.print("Bodies: " .. world:getBodyCount(), 8, 16)
            love.graphics.print("ship coords: " .. x .. " " .. y, 8, 24)
            love.graphics.line(512,100, 512, 300)
        love.graphics.pop()
    end
end

function love.mousepressed(x, y, button)
    local x_off, y_off = colony_ship:world_coords()
    local screen_x = x - (love.window.getWidth()/2 - x_off)
    local screen_y = y - (love.window.getHeight()*0.6 - y_off)

    world:queryBoundingBox(screen_x-1, screen_y-1, screen_x+1, screen_y+1,
        function (f)
            local target = f:getUserData()
            if target.onclick then
                target:onclick();
            end
            return false
        end)

    last_click = {screen_x, screen_y}
end

