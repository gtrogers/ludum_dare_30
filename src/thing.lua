-- very basic class system

local Thing = Thing

Thing = {}

Thing.__call = function(class, ...)
    local instance = {}
    if class.init then
        class.init(instance, ...)
    end
    class.__index = class
    setmetatable(instance, class)
    return instance
end

Thing.new = function ()
    local class = {}
    setmetatable(class, Thing)
    return class
end

return Thing

