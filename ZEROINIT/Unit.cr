module ZEROINIT

    class Unit

        include JSON::Serializable

        property name : String
        property description : String

        def initialize

        end

        def self.loadConfiguration(path : String)
            return from_json(File.read(path))
        end

        def runSystemCommand(command : String) : ZEROINIT::ProcessResult
            commandOutput = IO::Memory.new

            process = Process.run(  command: command,
                                    output: commandOutput,
                                    shell: true)

            output = commandOutput.to_s.strip

            commandOutput.clear

            return ZEROINIT::ProcessResult.new(output, process)
        end

        def start
        end

        def stop
        end

    end

end
