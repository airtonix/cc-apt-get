    local args =  { ... }
    local res = http.get("https://raw.github.com/Arqade/cc-apt-get/master/apt-get/apt-get.lua")

    if res then
        local content = res.readAll()
        res.close()
        fs.makeDir("apt")
        local file = fs.open("apt/apt-get", "w")
        file.write(content)
        file.close()
        shell.setAlias("apt-get", "apt/apt-get")
    end
