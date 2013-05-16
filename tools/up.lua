function move()
    return turtle.up()
end

local tArgs = { ... }
local dst

if #tArgs > 0 then
    dst = tArgs[1]
else
    dst = 1;
end

-- save
if dst == "0" then
print("Please confirm going max up? [yes/no]")
local ans = read()

if not (ans == "yes") then
    exit()
end
end

if dst ~= "0" then
    for i = 1, dst do
        move()
    end
else
    while move() do
    end
end