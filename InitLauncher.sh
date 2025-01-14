#!/bin/bash
mount -o remount,rw /
mount -o nosuid,noexec,nodev /proc
source /etc/profile
exec zeroinit
