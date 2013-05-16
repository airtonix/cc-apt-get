-- pastebin get m102eGTL apt-get
--
-- Help
-- apt-get 
-- -setup (the first time)
-- -install <package>
-- -list
-- -update
-- -upgrade

srcFile = "apt/source.list"
packFile = "apt/packages"
packList = "apt/installed"

function checkFile(name)
    if not fs.exists(name) then
        print("Package file does not exist. Run apt-get update")
        error()
    end
end

function checkPackfile()
    checkFile(packFile)
end

function checkPacklist()
    checkFile(packList)
end 

function pastebin(key, name)
    if fs.exists(name) then
        fs.delete(name)
    end

    shell.run("pastebin", "get", key, name)
end

function tryRead(file)
    local line = file.readLine()

    return line
end


function readPackage(file) 
    local pack = {}
    pack.name = tryRead(file)
    if pack.name == nil then 
        return nil
    end
    pack.description = tryRead(file)
    if pack.description == nil then 
        return nil
    end
    pack.key = tryRead(file)
    if pack.key == nil then 
        return nil
    end
    pack.directory = tryRead(file)
    if pack.directory == nil then 
        return nil
    end
    pack.alias = tryRead(file)
    if pack.alias == nil then 
        return nil
    end

    return pack
end

function writePackage(file, package)
    file.writeLine(package.name)
    file.writeLine(package.description)
    file.writeLine(package.key)
    file.writeLine(package.directory)
    file.writeLine(package.alias)
end

function setup()
    -- First time setup
    fs.makeDir("apt")
    local defaultApt
    print("Please set your apt source pastebin key [default: Vt0v208y]")
    defaultApt = read()

    if defaultApt == "" then
        defaultApt = "Vt0v208y"
    end

    if fs.exists(srcFile) then
        fs.delete(srcFile)
    end

    local src = fs.open(srcFile, "w")
    src.writeLine(defaultApt)
    src.close()

    p = fs.open(packList, "w")
    p.close()
end

function update()
    -- Update packages
    if not fs.exists(srcFile) then
        print("apt/source.list does not exist! Abording.")
        error()
    end

    local source = fs.open(srcFile, "r")
    local packKey = source.readLine()
    source.close()

    pastebin(packKey, packFile)
end

function list() 
    checkPackfile()
    pack = fs.open(packFile, "r")

    local EOF = false
    local i = 1
    while not EOF do
        package = readPackage(pack)
        if package == nil then
            EOF = true
        else
            print("Package: " .. package.name)
            print("Description: " .. package.description)
        end
        if i % 2 == 0 then
            read()
        end

        i = i + 1
    end

    print(i .. " packages listed")
end

function upgrade()
    checkPackfile()
    pack = fs.open(packList, "r")

    local package = {}

    local EOF = false

    while not EOF do
        package = readPackage(pack)
        if package == nil then
            EOF = true
        else
            -- Upgrade it
            print("Upgrading package " .. package.name)
            pastebin(package.key, package.directory .. "/" ..package.name)
            -- TODO: check for missing Alias
            -- print("Setting up package " .. package.name)
            -- shell.setAlias(package.alias, package.directory .. "/" .. package.name)
        end
    end
    pack.close()
end

function install(lookingFor)
    --TODO: is package already installed

    checkPackfile()
    pack = fs.open(packFile, "r")

    local package = {}

    local found = false
    local EOF = false

    while not found and not EOF do
        package = readPackage(pack)
        if package == nil then
            EOF = true
        elseif package.name == lookingFor then
            found = true
        end
    end
    pack.close()

    if found then
        if package.alias == "virtual" then
            for token in string.gmatch(package.key, "[^%s]+") do
                install(token)
            end
        else
            -- Install it
            print("Selecting previously deselected package " .. package.name)
            checkPacklist()
            list = fs.open(packList, "a")
            writePackage(list, package)
            list.close()
            if not fs.exists(package.directory) then
                print ("Creating " .. package.directory)
                fs.makeDir(package.directory)
            end
            pastebin(package.key, package.directory .. "/" ..package.name)
            print("Setting up package " .. package.name)
            shell.setAlias(package.alias, package.directory .. "/" .. package.name)
        end
    else
        print("Package " .. lookingFor .. " not found")
    end
end

local args = { ... }

if args[1] == "update" then
    update()
elseif args[1] == "list" then
    list()
elseif args[1] == "install" then
    install(args[2])
elseif args[1] == "remove" then
    print("Unimplemented")
elseif args[1] == "upgrade" then
    upgrade()
elseif args[1] == "setup" then
    setup()
    update()
else
    print("Argument unknown")
end