#  adebian@beaglebone:~$ cat run.sh 
sudo /home/debian/extract.sh
ls -ltar /lib/modules/5.7*
ls -ltar /boot/dtbs/5.7*
echo sudo reboot
# debian@beaglebone:~$ cat extract.sh 
sudo date -s "9 JUL 2020 11:14:00"
sudo tar -C / -xvf 5.7.0-rc6-omap2plus-r0-modules.tar.gz
sudo tar -C /boot/dtbs/5.7.0-rc6-omap2plus-r0/ -xvf 5.7.0-rc6-omap2plus-r0-dtbs.tar.gz
sudo cp 5.7.0-rc6-omap2plus-r0.zImage /boot/vmlinuz-5.7.0-rc6-omap2plus-r0
##############################
# refresh.sh
###############################
#!/bin/bash


SLEEP="$1"

if [ -z "$1" ]; then
        SLEEP=0
fi

echo SLEEP=$SLEEP

while [ /bin/true ]; do
        dhclient -r enx9884e391a556
        dhclient enx9884e391a556
        ifconfig enx9884e391a556
        dhclient -r enx1cba8ca2ed6c
        dhclient enx1cba8ca2ed6c
        ifconfig enx1cba8ca2ed6c
        dhclient -r eth0
        dhclient eth0
        ifconfig eth0
        dhclient -r eth1
        dhclient eth1
        ifconfig eth1
        if [ "$SLEEP" = "0" ]; then
                exit 0
        fi

        sleep $SLEEP
done

# sudo ~/bin/refresh.sh && ./tools/rebuild.sh && scp deploy/*.* debian@192.168.7.2:. && ssh debian@192.168.7.2 'sudo ~/run.sh' && sudo ~/bin/refresh.sh 30
