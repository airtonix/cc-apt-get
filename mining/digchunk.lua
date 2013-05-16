-- Chunk digger
--
-- ^|^|^|^|^|^|^|^|
-- xxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxx
-- Sxxxxxxxxxxxxxxx
--
-- S: Start (should be one block above the layer to be digged)
--
-- digchunk <height>

function digItMove() 
    while turtle.detect() do
        turtle.dig()
        sleep(0.5)
    end
    turtle.forward()
end

function digSquare() 
    -- Do one square
    for i = 1, 16 do
        for j = 1, 15 do
            digItMove()
        end

        if i ~= 16 then
            if i % 2 == 1 then
                turtle.turnRight()
                digItMove()
                turtle.turnRight()
            else
                turtle.turnLeft()
                digItMove()
                turtle.turnLeft()
            end
        else
            -- Last one
            turtle.turnRight()
            -- Back to S
            for k = 1, 15 do
                turtle.forward()
            end
            turtle.turnRight()
        end
    end

end

local args = { ... }

if #args < 1 then
    print("You must put an argument to choose your height")
    return -1
end

local height = tonumber(args[1])

while turtle.getFuelLevel() < ((256 + 20) * height) do
    -- Check fuel
    -- 16x16 = 256
    turtle.select(1)
    print("Fuel level is insufficient (Needs: ", ((256 + 20) * height) - turtle.getFuelLevel(), " more)")
    print("Please refuel slot 1 and press <Enter>")
    read()
    turtle.refuel(64)
end

for h = 1, height do
    -- Dig the first block
    turtle.digDown()
    turtle.down()

    digSquare()
end