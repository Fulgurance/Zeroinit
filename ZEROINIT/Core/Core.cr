module ZEROINIT

    module Core

        def self.runSystemCommand(command : String) : ZEROINIT::ProcessResult
            commandOutput = IO::Memory.new

            array = command.split(" ")

            process = Process.run(  command: array[0],
                                    args: array[1..-1],
                                    output: commandOutput,
                                    shell: false)

            output = commandOutput.to_s.strip

            commandOutput.clear

            return ZEROINIT::ProcessResult.new(output, process)
        end

        def self.loadUnitDatabase : Array(String)
            return ["Keymaps","Network","Filesystems","Bluetooth","NetworkManager"]
        end

        def self.startUnit(name : String)
            Notification.printUnit(name)
        end

        def self.stopUnit

        end

    end

end
