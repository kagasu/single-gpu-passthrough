#!/bin/bash

if test -e /etc/libvirt/ && ! test -e /etc/libvirt/hooks;
then
    mkdir -p /etc/libvirt/hooks;
fi
if test -e /etc/libvirt/hooks/qemu;
then
    mv /etc/libvirt/hooks/qemu /etc/libvirt/hooks/qemu_last_backup
fi
if test -e /bin/vfio-startup;
then
    mv /bin/vfio-startup /bin/vfio-startup.bkp
fi
if test -e /bin/vfio-teardown;
then
    mv /bin/vfio-teardown /bin/vfio-teardown.bkp
fi
if test -e /etc/systemd/system/libvirt-nosleep@.service;
then
    rm /etc/systemd/system/libvirt-nosleep@.service
fi

cp systemd-no-sleep/libvirt-nosleep@.service /etc/systemd/system/libvirt-nosleep@.service
cp hooks/vfio-startup /bin/vfio-startup
cp hooks/vfio-teardown /bin/vfio-teardown
cp hooks/qemu /etc/libvirt/hooks/qemu

chmod +x /bin/vfio-startup
chmod +x /bin/vfio-teardown
chmod +x /etc/libvirt/hooks/qemu
