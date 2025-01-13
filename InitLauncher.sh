#!/bin/bash
mount -o remount,rw /
mount --make-rshared /
mount -o nosuid,noexec,nodev /proc
source /etc/profile
exec zeroinit
