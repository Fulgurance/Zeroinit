module ZEROINIT

    class InitializationSystem

        def initialize

        end

        def start
            printInitializationTitle
            printSystemInformation
            printStartingUnitsTitle
            printStartingUnits
        end

        def progressivePrint(text : String, speed = 20)
            text.each_char do |character|
                #sleep(Time::Span.new(nanoseconds: speed*1000000))

                print character
            end

            rescue error
                pp error
        end

        def printInitializationTitle
            puts

            prefix = "[ ".colorize(:green)
            initName = ZEROINIT::Default::InitializationSystem::Name.colorize(Colorize::ColorRGB.new(255,100,100)).mode(:bold)
            loadingText = ZEROINIT::Default::InitializationSystem::InitializationText
            suffix = " ]".colorize(:green)

            progressivePrint(   text: "#{prefix}#{loadingText} #{initName}#{suffix}\n")

            puts

            rescue error
                pp error
        end

        def version : String
            return "0.0.0"

            rescue error
                pp error
                return String.new
        end

        def kernel : String
            return "Linux"

            rescue error
                pp error
                return String.new
        end

        def architecture : String
            return "x86_64"

            rescue error
                pp error
                return String.new
        end

        def operatingSystem : String
            return "Resilience"

            rescue error
                pp error
                return String.new
        end

        def printSystemInformation

            space = "     "
            versionTitle = ZEROINIT::Default::InitializationSystem::VersionTitle.colorize(:green)
            kernelTitle = ZEROINIT::Default::InitializationSystem::KernelTitle.colorize(:green)
            architectureTitle = ZEROINIT::Default::InitializationSystem::ArchitectureTitle.colorize(:green)
            operatingSystemTitle = ZEROINIT::Default::InitializationSystem::OperatingSystemTitle.colorize(:green)

            progressivePrint(   text: "#{space}#{versionTitle}: #{version}\n")

            progressivePrint(   text: "#{space}#{kernelTitle}: #{kernel}\n")

            progressivePrint(   text: "#{space}#{architectureTitle}: #{architecture}\n")

            progressivePrint(   text: "#{space}#{operatingSystemTitle}: #{operatingSystem}\n")

            puts

            rescue error
                pp error
        end

        def printStartingUnitsTitle

            prefix = "\t{ "
            text = ZEROINIT::Default::InitializationSystem::StartingUnitsTitle.colorize(:green)
            suffix = " }"

            progressivePrint(   text: "#{prefix}#{text}#{suffix}\n")

            puts

            rescue error
                pp error
        end

        def printUnit(name : String, spaceNumber = 1, status = :success)

            prefix = "\t\t#{ZEROINIT::Default::InitializationSystem::ProcessNotificationCharacters}".colorize(:green)
            statusText = String.new

            case status
            when :success
                statusText = ZEROINIT::Default::InitializationSystem::UnitSuccessText.colorize(:green)
            when :loading
                statusText = ZEROINIT::Default::InitializationSystem::UnitLoadingText.colorize(:yellow)
            when :failure
                statusText = ZEROINIT::Default::InitializationSystem::UnitFailureText.colorize(:red)
            end

            puts "#{prefix} #{name}\t\t\t#{statusText}\n"

            rescue error
                pp error
        end

        #TESTS PURPOSE
        def startUnit(unit)
            printUnit(  name: unit)

            rescue error
                pp error
        end

        def printStartingUnits(unitList = loadUnitDatabase)
            unitList.each do |unit|
                startUnit(unit)
            end

            rescue error
                pp error
        end

        #TESTS PURPOSE
        def loadUnitDatabase : Array(String)
            #Must be implement
            return ["Keymaps","Network","Filesystems","Bluetooth","NetworkManager"]

            rescue error
                pp error
                return Array(String).new
        end

    end

end
