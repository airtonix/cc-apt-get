# Computer Craft Apt-get

This is a clone of the famous apt-get packet manager of Debian for Computer
Craft.

This tools is currently under development. If you want to participat, please ask
me.

## Installation


### Get the installer

First you need to get the installer

There are two methods to installing apt-get, create the installer yourself, or install via pastebin (ironic yeah?)


**Roll your own**

```
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
```

**Via pastebin.com**

`pastebin get bRdpFcrD getapt`



### Initial Setup

#### Install it

`> getapt`

#### Set it up

`> apt-get setup`

The script will prompt you to choose the pastebin repository or github
repository. We strongly recommend the github method as I will not support the
pastebin default repository anymore. But you can still setup yours.

#### Add some repositories

`> edit apt/source.list` 


#### Update package index

`> apt-get update`.


## Updating

apt-get will upgrade itself if you put this github repo in the sources.list

See https://github.com/Arqade/cc-apt-get/blob/master/apt-get/source.list#L1-L5 for details.



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


