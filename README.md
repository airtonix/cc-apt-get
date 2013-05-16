# Computer Craft Apt-get

This is a clone of the famous apt-get packet manager of Debian for Computer
Craft.

This tools is currently under development. If you want to participat, please ask
me.

## Installation

1. Copy this script on a disk :

	
    local args =  { ... }
    local res = http.get("https://raw.github.com/Arqade/cc-apt-get/master/apt-get/apt-get.lua")

    if res then
        local content = res.readAll()
        res.close()
        fs.makeDir("apt")
        local file = fs.open("apt/apt-get", "w")
        file.write(content)
        file.close()
        shell.alias("apt-get", "apt/apt-get")
    end

(pastebin get rbVg5jHU getapt)

2. run the script `> getapt`
3. run `> apt-get setup`
The script will prompt you to choose the pastebin repository or github
repository. We strongly recommend the github method as I will not support the
pastebin default repository anymore. But you can still setup yours.
4. Edit `apt/source.list` if you want to set up your own repository, then run
   `apt-get update`. Note: please provide a link to the `apt-get.lua` script if
   you want to auto-upgrade it.

You are ready to go!


## Team work

If you are a member of the Arqade Community and want to help develop this tool,
please contact me via the chat. If you are not member of the Arqade community,
you are still welcome to submit issues and/or pull requests.

Note that the source.list on this repository will be manage by and for the
Arqade community. Please fork when necessary.

## Disclaimer

The source listing may refer to work made by non-members.

## TODO

- Add multiple repository in source.list


