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
run     apt-get install -y firefox icedtea-6-plugin icedtea-netx openjdk-6-jre openjdk-6-jre-headless tzdata-java 
run apt-get install -y apt-utils 
run apt-get install -y dbus-x11
run ln -s /var/lib/dbus/machine-id /etc/machine-id
run	mkdir ~/.vnc
# Setup a password
run	x11vnc -storepasswd 1234 ~/.vnc/passwd
#machine id
# Autostart firefox (might not be the best way to do it, but it does the trick)
run     bash -c 'echo "exec openbox-session &" >> ~/.xinitrc'
run	bash -c 'echo "firefox" >> ~/.xinitrc'
run     bash -c 'chmod 755 ~/.xinitrc'
