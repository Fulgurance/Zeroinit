module ZEROINIT

    class InitializationSystem

        def initialize

        end

        def start
 #
	# # Mount required directories as user may not have them in /etc/fstab
	# for x in \
	# 	"mqueue /dev/mqueue 1777 ,nodev mqueue" \
	# 	"devpts /dev/pts 0755 ,gid=5,mode=0620 devpts" \
	# 	"tmpfs /dev/shm 1777 ,nodev,mode=1777 shm" \
	# ; do
	# 	set -- $x
	# 	grep -Eq "[[:space:]]+$1$" /proc/filesystems || continue
	# 	mountinfo -q $2 && continue
 #
	# 	if [ ! -d $2 ]; then
	# 		mkdir -m $3 -p $2 >/dev/null 2>&1 || \
	# 			ewarn "Could not create $2!"
	# 	fi
 #
	# 	if [ -d $2 ]; then
	# 		ebegin "Mounting $2"
	# 		if ! fstabinfo --mount $2; then
	# 			mount -n -t $1 -o noexec,nosuid$4 $5 $2
	# 		fi
	# 		eend $?
	# 	fi
	# done
            command1 = "mknod -m 620 /dev/tty1 c 4 1 && mknod -m 666 /dev/tty c 5 0 && mknod -m 666 /dev/null c 1 3 && mknod -m 660 /dev/kmsg c 1 11"
            process = Process.run(  "#{command1}",
                                        output: Process::Redirect::Inherit,
                                        error: Process::Redirect::Inherit,
                                        shell: true)
            #
            # command2 = "ln -snf /proc/self/fd /dev/fd && ln -snf /proc/self/fd/0 /dev/stdin && ln -snf /proc/self/fd/1 /dev/stdout && ln -snf /proc/self/fd/2 /dev/stderr && ln -snf /proc/kcore /dev/core"
            # process = Process.run(  "#{command2}",
            #                             output: Process::Redirect::Inherit,
            #                             error: Process::Redirect::Inherit,
            #                             shell: true)

            rescue error
                puts error
                puts "Continue anyway"

            # printInitializationTitle
            # printSystemInformation
            # printStartingUnitsTitle
            # printStartingUnits
        end

        def progressivePrint(text : String, speed = 20)
            text.each_char do |character|
                #sleep(Time::Span.new(nanoseconds: speed*1000000))

                print character
            end

        end

        def printInitializationTitle
            puts

            prefix = "[ ".colorize(:green)
            initName = ZEROINIT::Default::InitializationSystem::Name.colorize(Colorize::ColorRGB.new(255,100,100)).mode(:bold)
            loadingText = ZEROINIT::Default::InitializationSystem::InitializationText
            suffix = " ]".colorize(:green)

            progressivePrint(   text: "#{prefix}#{loadingText} #{initName}#{suffix}\n")

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

            puts "#{prefix} #{name}\t\t\t#{statusText}\n"
        end

        #TESTS PURPOSE
        def startUnit(unit)
            printUnit(  name: unit)
        end

        def printStartingUnits(unitList = loadUnitDatabase)
            unitList.each do |unit|
                startUnit(unit)
            end
        end

        #TESTS PURPOSE
        def loadUnitDatabase : Array(String)
            #Must be implement
            return ["Keymaps","Network","Filesystems","Bluetooth","NetworkManager"]
        end

    end

end
