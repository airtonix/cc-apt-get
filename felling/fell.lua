--pastebin get 19Xs1uPL fell
local dst = 0
turtle.dig()
turtle.forward()
while turtle.detectUp() do
  turtle.digUp()
  turtle.up()
  dst = dst + 1
end
while turtle.down() do
end
print("Total dst : ", dst * 2)