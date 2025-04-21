# TFTP/PXE/NFS SETUP

1. Setup Windows dhcp server
2. Authorize it, set up your scope
    1. Server Options 66/67
        1. Point to tftp server
        2. /EFI/BOOT/BOOTX64.EFI (secure boot)
            1. secureboot = shimx64.efi
            2. unsecure = grubx64.efi
            3. RENAME FILES TO BOOTX64.EFI (HARDCODED IN PXE)
        

LINUX SETUP (nfs) (SERVER WITH INSTALL FILES FOR PXE CLIENTS)

1. yum install grub2-efi shim tftp-server
2. sudo systemctl enable --now tftp.socket
3. firewall-cmd —add-service=tftp —permanent
4. firewall-cmd —reload
5. IF SERVING REPO NFS (WILL TRY TO MOUNT NFS3, NOT NFS4)
    1. ints.repo=nfs:someip:/nfs/share
        1. NEED TO ALLOW
        
        sudo firewall-cmd --add-service=nfs --add-service=mountd --add-service=rpc-bind --permanent
        sudo firewall-cmd --reload
        

![image.png](TFTP%20PXE%20NFS%20SETUP%201db6269e7c308004ae97c753132c18bd/image.png)

GRUB.CFG

![image.png](TFTP%20PXE%20NFS%20SETUP%201db6269e7c308004ae97c753132c18bd/image%201.png)

WE can add KICKSTART for luks and nfs install and maybe STIG 

1. liinuxefi → /vmlinuz → LOCATED INSIDE /var/lib/tftpboot/vmlinuz
2. initrdefi → /initrd.img → LOCATED INSIDE /var/lib/tftpboot/initrd.img
    1. inst.repo is ENOUGH to point otinstall media
        1. inst.stage2 ONLY neede if repo and install files were separate locations

TFTP DIR IS ( /var/lib/tftpboot ) DEFAULT

PERMS?

1. chmod -R 755 /var/lib/tftpboot
2. SELinux → tftpdir_rw_t

![image.png](TFTP%20PXE%20NFS%20SETUP%201db6269e7c308004ae97c753132c18bd/image%202.png)

NFS/KS SETUP

1. ks.cfg with instructions for luks, mountpoint, nfs-utils, ip info, and mounting and running post script
2. grub.cfg needs ints.ks

![image.png](TFTP%20PXE%20NFS%20SETUP%201db6269e7c308004ae97c753132c18bd/image%203.png)

![image.png](TFTP%20PXE%20NFS%20SETUP%201db6269e7c308004ae97c753132c18bd/image%204.png)

[https://github.com/rodrigorenteriatx/redhat-files/blob/main/ks.cfg](https://github.com/rodrigorenteriatx/redhat-files/blob/main/ks.cfg)

[https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/system_design_guide/kickstart-commands-and-options-reference_system-design-guide](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/system_design_guide/kickstart-commands-and-options-reference_system-design-guide)
