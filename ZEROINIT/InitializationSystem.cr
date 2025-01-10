module ZEROINIT

    class InitializationSystem

        def initialize

        end

        def start
            printInitializationTitle
            printSystemInformation
            printStartingUnitsTitle
            #printStartingUnits

            loadUnitDatabase
        end

        def progressivePrint(text : String, speed = 20)
            text.each_char do |character|
                #sleep(Time::Span.new(nanoseconds: speed*1000000))

                print character
            end

        end

        def printInitializationTitle
            puts

            textSpeed = 30

            prefix = "[ ".colorize(:green)
            initName = ZEROINIT::Default::InitializationSystem::Name.colorize(Colorize::ColorRGB.new(255,100,100)).mode(:bold)
            loadingText = ZEROINIT::Default::InitializationSystem::InitializationText
            suffix = " ]".colorize(:green)

            progressivePrint(   text: "#{prefix}#{loadingText} #{initName}#{suffix}\n",
                                speed: textSpeed)

            puts
        end

        def version : String
            return "0.0.0"
        end

        def kernel : String
            return "Linux"
        end

        def architecture : String
            return "x86_64"
        end

        def operatingSystem : String
            return "Resilience"
        end

        def printSystemInformation

            textSpeed = 10

            space = "     "
            versionTitle = ZEROINIT::Default::InitializationSystem::VersionTitle.colorize(:green)
            kernelTitle = ZEROINIT::Default::InitializationSystem::KernelTitle.colorize(:green)
            architectureTitle = ZEROINIT::Default::InitializationSystem::ArchitectureTitle.colorize(:green)
            operatingSystemTitle = ZEROINIT::Default::InitializationSystem::OperatingSystemTitle.colorize(:green)

            progressivePrint(   text: "#{space}#{versionTitle}: #{version}\n",
                                speed: textSpeed)

            progressivePrint(   text: "#{space}#{kernelTitle}: #{kernel}\n",
                                speed: textSpeed)

            progressivePrint(   text: "#{space}#{architectureTitle}: #{architecture}\n",
                                speed: textSpeed)

            progressivePrint(   text: "#{space}#{operatingSystemTitle}: #{operatingSystem}\n",
                                speed: textSpeed)

            puts
        end

        def printStartingUnitsTitle

            prefix = "\t{ "
            text = ZEROINIT::Default::InitializationSystem::StartingUnitsTitle.colorize(:green)
            suffix = " }"

            progressivePrint(   text: "#{prefix}#{text}#{suffix}\n")

            puts
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

            puts "#{prefix} #{name}#{space}#{statusText}\n"
        end

        #TESTS PURPOSE
        def startUnit(unit, quietMode = false)
            quietMode = (quiet ? Process::Redirect::Close : Process::Redirect::Inherit)

            # process = Process.run(  "./#{unit.filePath}",
            #                         output: quietMode,
            #                         error: quietMode,
            #                         shell: true)

            #printUnit(unit)

            randomStatus = [:loading, :success, :failure].sample

            printUnit(  name: unit,
                        status: randomStatus)

            rescue
                printUnit(unit, :failure)
        end

        def printStartingUnits(unitList = loadUnitDatabase)
            unitList.each do |unit|
                startUnit(unit)
            end
        end

        #TESTS PURPOSE
        def loadUnitDatabase : Array(String)
            #Must be implement
            return ["Keymaps","Network","Filesystems","Bluetooth","NetworkManager"]#Array(String).new
        end

    end

end
