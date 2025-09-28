module ZEROINIT

    module Core

        module System

            #Halt syscall
            def self.halt
                SystemCall.sync
                SystemCall.reboot(  magic:  0xfee1dead,
                                    magic2: 0x28121969,
                                    op:     0xcdef0123)
            end

            #Poweroff syscall
            def self.powerOff
                SystemCall.sync
                SystemCall.reboot(  magic:  0xfee1dead,
                                    magic2: 0x28121969,
                                    op:     0x4321fedc)
            end

            #Restart syscall
            def self.restart
                SystemCall.sync
                SystemCall.reboot(  magic:  0xfee1dead,
                                    magic2: 0x28121969,
                                    op:     0x1234567)
            end

            #Perform a proper init shutdown and then a poweroff syscall
            def self.shutdown

                powerOff
            end

            #Perform a proper init shutdown and then a restart syscall
            def self.reboot

                restart
            end

        end

    end

end
