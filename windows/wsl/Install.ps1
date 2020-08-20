$name = $args[0].ToLower()
$dir = "$PSScriptRoot\$name"
$wslVersion = 1

$urls = @{
  alpine = "http://dl-cdn.alpinelinux.org/alpine/v3.12/releases/x86_64/alpine-minirootfs-3.12.0-x86_64.tar.gz"
  amazon = "https://github.com/yosukes-dev/AmazonWSL/releases/download/2.0.20200406.0/Amazon2.zip"
  arch = "https://github.com/yuk7/ArchWSL/releases/download/20.4.3.0/Arch.zip"
  centos = "https://github.com/yuk7/CentWSL/releases/download/8.1.1911.1/CentOS8.zip"
  scratch = "https://github.com/wight554/ClearWSL/releases/download/33490/Clear.zip"
  fedora = "https://github.com/yosukes-dev/FedoraWSL/releases/download/32.2006.0/Fedora32.zip"
  redhat = "https://github.com/yosukes-dev/RHWSL/releases/download/8.2-265/RHWSL.zip"
  debian = "https://www.dropbox.com/s/lx1xwi69gxasbeq/amd64-rootfs-20170318T102216Z.tar.gz?dl=1"
  ubuntu = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-wsl.rootfs.tar.gz"
}

if (!(Test-Path "rootfs.tar.gz")) {
  Write-Information "Downloading $name rootfs"
  Invoke-WebRequest -Uri $urls.$name -Out "$dir\rootfs.tar.gz"
}
