function placeForward(nb)
    turtle.select(1)
    while turtle.getItemCount(1) < nb do
        print("Not enough item in slot 1")
        read()
    end

    for i = 1, nb do
        turtle.forward()
        turtle.placeDown()
    end
end

local args = { ... }

lg = tonumber(args[1])

placeForward(lg)