#!/bin/bash
#Script for the easy installation of AMD Drivers on HiveOS/Ubuntu based OS
#Script By CryptoLuigi (Michael Ruperto)
#Contributors: miabo Cryptonuffe watertim
#Edit By mellyshelly
#Date: 2021-08-24

systemctl stop hivex
miner stop

echo
#mkdir /hive-drivers-pack/
cd /hive-drivers-pack/
echo "Please note Drivers with the 18.04 suffix require an OS upgrade, or On Hiveos u can download the latest beta from http://download.hiveos.farm/ and install on a fresh usb."
PS3='Please enter your choice Drivers: '

options=("19.50-967956-ubuntu-18.04" "20.40-1147287-ubuntu-18.04" "21.30-1286092-ubuntu-18.04" "Quit")

select opt in "${options[@]}"
do
case $opt in
    	
    ;;
	"19.30-838629-ubuntu-18.04")
	wget http://download.hiveos.farm/drivers/amdgpu-pro-19.30-838629-ubuntu-18.04.tar.xz
        version="19.30-838629-ubuntu-18.04";break
    ;;
	"19.50-967956-ubuntu-18.04")
	wget http://download.hiveos.farm/drivers/amdgpu-pro-19.50-967956-ubuntu-18.04.tar.xz
        version="19.50-967956-ubuntu-18.04";break
   ;;
        "20.40-1147287-ubuntu-18.04.tar.xz")
        wget http://download.hiveos.farm/drivers/amdgpu-pro-20.40-1147287-ubuntu-18.04.tar.xz
   ;;
	"21.30-1286092-ubuntu-18.04")
	curl --referer https://drivers.amd.com/drivers/linux/amdgpu-pro-21.30-1286092-ubuntu-18.04.tar.xz
        version="21.30-1286092-ubuntu-18.04";break
    ;;
	"Quit")
	exit
        break
    ;;
    *)
        echo "Invalid option $REPLY"
    ;;
    esac
done

echo
read -p "Do you want have RX4xx/RX5xx?(y/n)" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    tar -Jxvf amdgpu-pro-$version.tar.xz
    echo
    read -p "Do you want remove current AMD Drivers?(y/n)" -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
		/usr/bin/amdgpu-pro-uninstall
		apt-get remove vulkan-amdgpu-pro*
	fi
	cd amdgpu-pro-$version
    apt-get -f install
    ./amdgpu-pro-install --opencl=legacy -y
    dpkg -l amdgpu-pro
    exit
fi

tar -Jxvf amdgpu-pro-$version.tar.xz
cd amdgpu-pro-$version
./amdgpu-pro-install -y
dpkg -l amdgpu-pro
