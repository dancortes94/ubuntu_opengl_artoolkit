#!/bin/bash
sudo apt-get update
sudo apt-get install -y bison build-essential clang-3.8 cmake cmake-data coreutils cpp cpp-6
sudo apt-get install -y diffstat diffutils g++ g++-6 gcc gcc-6 gcc-6-base git imagemagick
sudo apt-get install -y imagemagick-6.q16 imagemagick-common klibc-utils libc-bin libc-dev-bin libc6 libc6-dbg libc6-dev
sudo apt-get install -y libclang-common-3.8-dev libclang1-3.8  libfl-dev libgc1c2 libgcab-1.0-0
sudo apt-get install -y libgcc-6-dev libgcc1 libgck-1-0 libgconf-2-4 libgcr-3-common libgcr-base-3-1 libgcr-ui-3-1 libgd3
sudo apt-get install -y libgdal20 libgdata-common libgdata22 libgdk-pixbuf2.0-0 libgdk-pixbuf2.0-common
sudo apt-get install -y libgdk-pixbuf2.0-dev libgif7 libgirepository-1.0-1 libglu1-mesa libglu1-mesa-dev libgphoto2-6 libgphoto2-l10n
sudo apt-get install -y libgphoto2-port12 libgtk-3-0 libgtk-3-bin libgtk-3-common libgtk-3-dev libgtk2.0-0 libgtk2.0-bin libgtk2.0-common
sudo apt-get install -y libgtk2.0-dev libjpeg-dev libjpeg-turbo8 libjpeg-turbo8-dev libjpeg8 libjpeg8-dev
sudo apt-get install -y libpng-dev libpng-tools
sudo apt-get install -y libpng16-16 libsgutils2-2 libv4l-0 libv4l-dev libv4l2rds0 libv4lconvert0 libx11-6 libx11-data
sudo apt-get install -y libx11-dev libx11-doc libx11-protocol-perl libx11-xcb-dev libx11-xcb1 libxi-dev libxi6 libxi6-dbg
sudo apt-get install -y libxinerama-dev libxinerama1 libxkbcommon-dev
sudo apt-get install -y libxkbcommon-x11-0 libxkbcommon0 libxkbfile1 libxrandr-dev libxrandr2 libxrender-dev libxrender1 llvm-3.6 llvm-3.6-dev
sudo apt-get install -y llvm-3.6-runtime llvm-3.8 llvm-3.8-dev llvm-3.8-runtime make pkg-config
sudo apt-get install -y freeglut3 freeglut3-dev

cd
mkdir programacion_graficos
mkdir programacion_graficos/zips
cd ~/programacion_graficos
cd zips
pwd
wget http://prdownloads.sourceforge.net/freeglut/freeglut-3.0.0.tar.gz
tar zxvf freeglut-3.0.0.tar.gz
cd ~/programacion_graficos/zips/freeglut-3.0.0/
cmake .
make
sudo  make install
cd ~/programacion_graficos/zips/
git clone --branch OpenSceneGraph-3.4.0 https://github.com/openscenegraph/OpenSceneGraph.git
cd ~/programacion_graficos/zips/OpenSceneGraph
cmake .
make
sudo make install
cd ~/programacion_graficos/zips/
git clone https://github.com/opencv/opencv.git
cd ~/programacion_graficos/zips/opencv
git checkout 2.4
mkdir build
cd ~/programacion_graficos/zips/opencv/build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local ..
make -j7 # runs 7 jobs in parallel
sudo make install
cd ~/programacion_graficos/zips/
mkdir artoolkit
if [ "$(uname -m | grep '64')" != "" ]; then
    echo "ARCH: 64-bit"
    wget http://www.artoolkit.org/dist/artoolkit5/5.3/ARToolKit5-bin-5.3.2r1-Linux-x86_64.tar.gz
else
    echo "ARCH: 32-bit"
    wget http://www.artoolkit.org/dist/artoolkit5/5.3/ARToolKit5-bin-5.3.2r1-Linux-i686.tar.gz
fi

for f in *.tar.gz
do
    mv $f artoolkit/
    cd ~/programacion_graficos/zips/artoolkit
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
cd ~/programacion_graficos/zips/artoolkit/share
./artoolkit5-setenv
cd ~/programacion_graficos/zips/artoolkit
./Configure
make
