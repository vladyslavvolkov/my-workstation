$distribution = $args[0].ToLower()
$name = (Get-Culture).TextInfo.ToTitleCase($distribution)
$wslUser = "root"
$hostUser = $env:UserName
$wslBootstrapScript = "https://raw.githubusercontent.com/vladyslavvolkov/.env/master/wsl.sh"

Write-Information "Bootstrapping $distribution with Ansible"
wsl.exe --distribution $name --user $wslUser -- eval ("wget -qO- $wslBootstrapScript | HOST_USER=$hostUser OS=$distribution sh")

Write-Information "Restarting $name"
wsl.exe --terminate $name

