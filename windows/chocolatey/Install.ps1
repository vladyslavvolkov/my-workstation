#!/usr/bin/env powershell -File

$config = $args[0]
$name = (Get-Culture).TextInfo.ToTitleCase($config)

choco install "$PSScriptRoot\$name.Packages.config" --yes
