module SystemCall
    Syscall.def_syscall(sync, Void)
    Syscall.def_syscall(reboot, Int64, magic : Int64, magic2 : Int64, op : Int64)
end
