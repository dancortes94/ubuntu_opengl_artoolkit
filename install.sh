#!/bin/bash
sudo dpkg --set-selections < paquetes.txt && sudo apt-get -y -u dselect-upgrade
cd
mkdir programacion_graficos
mkdir programacion_graficos/zips
cd programacion_graficos/zips
if [ "$(uname -m | grep '64')" != "" ]; then
    echo "ARCH: 64-bit"
    wget http://www.artoolkit.org/dist/artoolkit5/5.3/ARToolKit5-bin-5.3.2r1-Linux-x86_64.tar.gz
else
    echo "ARCH: 32-bit"
    wget http://www.artoolkit.org/dist/artoolkit5/5.3/ARToolKit5-bin-5.3.2r1-Linux-i686.tar.gz
fi
git clone https://github.com/opencv/opencv.git
cd opencv
git checkout 2.4
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
make -j7 # runs 7 jobs in parallel
cd ../..
mkdir artoolkit
for f in *.tar.gz
do
    mv $f artoolkit/
    cd artoolkit
    tar zxvf "$f"
done
echo "ARTOOLKIT5_ROOT=/home/dcortes/Downloads/ARToolkit; export ARTOOLKIT5_ROOT
PKG_CONFIG_PATH=/home/dcortes/Downloads/opencv-2.2.0-artoolworks/lib/pkgconfig; export PKG_CONFIG_PATH
 export ARTOOLKIT5_VCONF=\"-device=LinuxV4L2\"" >> ~/.profile
echo "ARTOOLKIT5_ROOT=/home/dcortes/Downloads/ARToolkit; export ARTOOLKIT5_ROOT
PKG_CONFIG_PATH=/home/dcortes/Downloads/opencv-2.2.0-artoolworks/lib/pkgconfig; export PKG_CONFIG_PATH
 export ARTOOLKIT5_VCONF=\"-device=LinuxV4L2\"" >> ~/.bash_profile
source ~/.profile
source ~/.bash_profile
cd share
./artoolkit5-setenv
cd ..
cd ./Configure
make
