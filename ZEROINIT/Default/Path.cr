module ZEROINIT

    module Default

        module Path
            
            ZeroinitDirectory = "zeroinit/"
            BinaryDirectory = "sbin/"
            UnitDirectory = "units/"
            RuntimeDataDirectory = "var/#{ZeroinitDirectory}"
            TemporaryDirectory = "tmp/#{ZeroinitDirectory}"
            SettingDirectory = "etc/#{ZeroinitDirectory}"
            LogDirectory = "var/log/#{ZeroinitDirectory}"
            LibraryDirectory = "usr/share/#{ZeroinitDirectory}"
            UnitDirectory = "#{RuntimeDataDirectory}"
            UnitSettingDirectory = "#{SettingDirectory}#{UnitDirectory}"

        end

    end

end
