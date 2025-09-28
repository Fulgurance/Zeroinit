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

        #HAVE TO BE IMPLEMENT
        def self.version : String
            return "Master"
        end

        def self.kernel : String
            processResult = Core.runSystemCommand("/usr/bin/uname -s")
            return processResult.output
        end

        def self.architecture : String
            processResult = Core.runSystemCommand("/usr/bin/uname -m")
            return processResult.output
        end

        def self.operatingSystem : String
            processResult = Core.runSystemCommand("/usr/bin/uname -o")
            return processResult.output
        end

        def initialize
        end

        def start
            Core::Notification.printInitializationTitle
            Core::Notification.printSystemInformation
            Core::Notification.printStartingUnitsTitle
            Core::Notification.printStartingUnits
        end

    end

end
