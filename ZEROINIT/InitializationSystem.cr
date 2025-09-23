module ZEROINIT

    class InitializationSystem

        module Default

            Name = "Zeroinit"
            InitializationText = "Initializing"
            VersionTitle = "VERSION"
            KernelTitle = "KERNEL"
            ArchitectureTitle = "ARCHITECTURE"
            OperatingSystemTitle = "OPERATING SYSTEM"
            StartingUnitsTitle = "Starting units"
            ProcessNotificationCharacters = "■"
            UnitSuccessText = "(ok)"
            UnitLoadingText = "(loading)"
            UnitFailureText = "(failure)"

        end

        def initialize
            mountRoot
            generateDevPts
            generateDevShm
            mountDefaultFileSystem
            mountSystemFileSystem
            generateRunLock
            setRunLockRights
            generateStdinSymlink
            generateStdoutSymlink
            generateStderrSymlink
            generateFdSymlink
            generateCoreSymlink
        end

        def start
            printInitializationTitle
            printSystemInformation
            printStartingUnitsTitle
            printStartingUnits
        end

        def mountRoot
            runSystemCommand("/usr/bin/mount -o remount,rw /")
        end

        def generateDevPts
            runSystemCommand("/usr/bin/mkdir -p /dev/pts")
        end

        def generateDevShm
            runSystemCommand("/usr/bin/mkdir -p /dev/shm")
        end

        def mountDefaultFileSystem
            runSystemCommand("/usr/bin/mount --fstab /etc/fstab.d/default --all")
        end

        def mountSystemFileSystem
            runSystemCommand("/usr/bin/mount --fstab /etc/fstab.d/system --all")
        end

        def generateRunLock
            runSystemCommand("/usr/bin/mkdir -p /run/lock")
        end

        def setRunLockRights
            runSystemCommand("/usr/bin/chmod 1777 /run/lock")
        end

        def generateStdinSymlink
            runSystemCommand("/usr/bin/ln -sf /proc/self/fd/0 /dev/stdin")
        end

        def generateStdoutSymlink
            runSystemCommand("/usr/bin/ln -sf /proc/self/fd/1 /dev/stdout")
        end

        def generateStderrSymlink
            runSystemCommand("/usr/bin/ln -sf /proc/self/fd/2 /dev/stderr")
        end

        def generateFdSymlink
            runSystemCommand("/usr/bin/ln -sfn /proc/self/fd /dev/fd")
        end

        def generateCoreSymlink
            runSystemCommand("/usr/bin/ln -sf /proc/kcore /dev/core")
        end

        def runSystemCommand(command : String) : ZEROINIT::ProcessResult
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

        #HAVE TO BE IMPLEMENT
        def version : String
            return "Master"
        end

        def kernel : String
            processResult = runSystemCommand("/usr/bin/uname -s")
            return processResult.output
        end

        def architecture : String
            processResult = runSystemCommand("/usr/bin/uname -m")
            return processResult.output
        end

        def operatingSystem : String
            processResult = runSystemCommand("/usr/bin/uname -o")
            return processResult.output
        end

        def progressivePrint(text : String, speed = 10)
            text.each_char do |character|
                sleep(Time::Span.new(nanoseconds: speed*1000000))

                print character
            end
        end

        def printInitializationTitle
            puts

            prefix = "[ ".colorize(:green)
            initName = Default::Name.colorize(Colorize::ColorRGB.new(255,100,100)).mode(:bold)
            loadingText = Default::InitializationText
            suffix = " ]".colorize(:green)

            progressivePrint(   text: "#{prefix}#{loadingText} #{initName}#{suffix}\n")

            puts
        end

        def printSystemInformation

            space = "     "
            versionTitle = Default::VersionTitle.colorize(:green)
            kernelTitle = Default::KernelTitle.colorize(:green)
            architectureTitle = Default::ArchitectureTitle.colorize(:green)
            operatingSystemTitle = Default::OperatingSystemTitle.colorize(:green)

            progressivePrint(   text: "#{space}#{versionTitle}: #{version}\n")

            progressivePrint(   text: "#{space}#{kernelTitle}: #{kernel}\n")

            progressivePrint(   text: "#{space}#{architectureTitle}: #{architecture}\n")

            progressivePrint(   text: "#{space}#{operatingSystemTitle}: #{operatingSystem}\n")

            puts
        end

        def printStartingUnitsTitle

            prefix = "\t{ "
            text = Default::StartingUnitsTitle.colorize(:green)
            suffix = " }"

            progressivePrint(   text: "#{prefix}#{text}#{suffix}\n")

            puts
        end

        def printUnit(name : String, spaceNumber = 1, status = :success)

            prefix = "\t\t#{Default::ProcessNotificationCharacters}".colorize(:green)
            statusText = String.new

            case status
            when :success
                statusText = Default::UnitSuccessText.colorize(:green)
            when :loading
                statusText = Default::UnitLoadingText.colorize(:yellow)
            when :failure
                statusText = Default::UnitFailureText.colorize(:red)
            end

            puts "#{prefix} #{name}\t\t\t#{statusText}\n"
        end

        def startUnit(unit)
            printUnit(unit)
        end

        def printStartingUnits(unitList = loadUnitDatabase)
            unitList.each do |unit|
                startUnit(unit)
            end
        end

        def loadUnitDatabase : Array(String)
            return ["Keymaps","Network","Filesystems","Bluetooth","NetworkManager"]
        end

    end

end
