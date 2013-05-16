function move()
    return turtle.down()
end

local tArgs = { ... }
local dst

if #tArgs > 0 then
    dst = tArgs[1]
else
    dst = 1;
end

if dst ~= "0" then
    for i = 1, dst do
        move()
    end
else
    while move() do
    end
end