#/bin/bash
#Install the packages in packages.txt
PXEHOST="rhel8-pxe"
CURRENTHOST="$(hostname)"

if [[ "$CURRENTHOST" != "PXEHOST" ]];then
        echo "This script must be run on a new pxe host (preconfiguration)"
        exit 1
fi

echo "Mount ksfiles on /mnt/ksfiles"

cd /mnt/ksfiles
xargs dnf install -y < packages.txt

#Setup basic firewall rules (ssh, nfs, splunk(port), DOD/SAP DROP zone, and echo-rpely and echo-request. ANy other necessary rules?

#Install Splunk and setup user  and crontab script

#Install clamav , user, and crontab script

#Setup AD Authentication

#Setup grub password and user? or is that va ansible ? 
