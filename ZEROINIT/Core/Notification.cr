module ZEROINIT

    module Core

        module Notification

            def self.printInitializationTitle
                puts

                prefix = "[ ".colorize(:green)
                initName = InitializationSystem::Default::Name.colorize(Colorize::ColorRGB.new(255,100,100)).mode(:bold)
                loadingText = InitializationSystem::Default::InitializationText
                suffix = " ]".colorize(:green)

                print "#{prefix}#{loadingText} #{initName}#{suffix}\n"

                puts
            end

            def self.printSystemInformation

                space = "     "
                versionTitle = InitializationSystem::Default::VersionTitle.colorize(:green)
                kernelTitle = InitializationSystem::Default::KernelTitle.colorize(:green)
                architectureTitle = InitializationSystem::Default::ArchitectureTitle.colorize(:green)
                operatingSystemTitle = InitializationSystem::Default::OperatingSystemTitle.colorize(:green)

                print "#{space}#{versionTitle}: #{InitializationSystem.version}\n"

                print "#{space}#{kernelTitle}: #{InitializationSystem.kernel}\n"

                print "#{space}#{architectureTitle}: #{InitializationSystem.architecture}\n"

                print "#{space}#{operatingSystemTitle}: #{InitializationSystem.operatingSystem}\n"

                puts
            end

            def self.printStartingUnitsTitle

                prefix = "\t{ "
                text = InitializationSystem::Default::StartingUnitsTitle.colorize(:green)
                suffix = " }"

                print "#{prefix}#{text}#{suffix}\n"

                puts
            end

            def self.printUnit(name : String, spaceNumber = 1, status = :success)

                prefix = "\t\t#{InitializationSystem::Default::ProcessNotificationCharacters}".colorize(:green)
                statusText = String.new

                case status
                when :success
                    statusText = InitializationSystem::Default::UnitSuccessText.colorize(:green)
                when :loading
                    statusText = InitializationSystem::Default::UnitLoadingText.colorize(:yellow)
                when :failure
                    statusText = InitializationSystem::Default::UnitFailureText.colorize(:red)
                end

                puts "#{prefix} #{name}\t\t\t#{statusText}\n"
            end

            def self.printStartingUnits(unitList = Core.loadUnitDatabase)
                unitList.each do |unit|
                    Core.startUnit(unit)
                end
            end

        end

    end

end
