$distribution = $args[0].ToLower()
$name = (Get-Culture).TextInfo.ToTitleCase($distribution)
$buildDir = "$PSScriptRoot\build"
$downloadDir = "$buildDir\tmp"
$rootfsDir = "$buildDir\rootfs"

$urls = @{
    alpine = "http://dl-cdn.alpinelinux.org/alpine/v3.12/releases/x86_64/alpine-minirootfs-3.12.0-x86_64.tar.gz"
    centos = "http://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.raw.tar.gz"
    debian = "https://www.dropbox.com/s/lx1xwi69gxasbeq/amd64-rootfs-20170318T102216Z.tar.gz?dl=1"
    ubuntu = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-wsl.rootfs.tar.gz"
}

if (!(Test-Path "$buildDir\tmp\$distribution.tar.gz")) {
    Write-Information "Downloading $distribution rootfs"
    Invoke-WebRequest -Uri $urls.$distribution -Out "$downloadDir\$distribution.tar.gz"
}

Write-Information "Importing $distribution from rootfs archive"
wsl.exe --import $name "$rootfsDir\$distribution" "$downloadDir\$distribution.tar.gz"
