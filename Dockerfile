# Firefox over VNC
#
# VERSION               0.2
# DOCKER-VERSION        0.3

from	ubuntu:12.04

# make sure the package repository is up to date
run	apt-get update

# Install vnc, xvfb in order to create a 'fake' display and firefox
run	apt-get install -y x11vnc xvfb openbox 

# Install the specific tzdata-java we need
#run     apt-get -y install wget

# Install Firefox and Java Plugins
#run apt-get install -y firefox=11.0+build1-0ubuntu4
run apt-get install -y aptitude bzip2 wget
run     apt-get install -y icedtea-6-plugin icedtea-netx openjdk-6-jre openjdk-6-jre-headless tzdata-java 
run apt-get install -y apt-utils 
run apt-get install -y dbus-x11
run ln -s /var/lib/dbus/machine-id /etc/machine-id
#more install
run apt-get install -y gcc g++ libstdc++6-4.5-dev unzip zip  yasm curl libcurl4-openssl-dev 
run apt-get install -y pkg-config
run apt-get install -y make
run apt-get install -y libgtk2.0-dev 
run apt-get install -y libnotify-dev 
run apt-get install -y libdbus-glib-1-dev
run apt-get install -y libiw-dev
run apt-get install -y libasound2-dev 
run apt-get install -y libxt-dev 
run apt-get install -y mesa-common-dev 
#firefox
WORKDIR /root
run ls
run wget https://ftp.mozilla.org/pub/firefox/releases/10.0.2/source/firefox-10.0.2.source.tar.bz2
#run wget https://ftp.mozilla.org/pub/firefox/releases/10.0.2/linux-i686/en-US/firefox-10.0.2.tar.bz2
run bzip2 -d firefox-10.0.2.source.tar.bz2 
run tar xvf firefox-10.0.2.source.tar 
WORKDIR /root/mozilla-release
run ls
run /root/mozilla-release/configure 
run make
run make install
run	mkdir ~/.vnc
# Setup a password
run	x11vnc -storepasswd 1234 ~/.vnc/passwd
#machine id
# Autostart firefox (might not be the best way to do it, but it does the trick)
run     bash -c 'echo "exec openbox-session &" >> ~/.xinitrc'
run	bash -c 'echo "firefox" >> ~/.xinitrc'
run     bash -c 'chmod 755 ~/.xinitrc'
