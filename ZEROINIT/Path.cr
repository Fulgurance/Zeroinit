module ZEROINIT

    module Path

        ZeroinitDirectory = "zeroinit/"
        BinaryDirectory = "sbin/"
        UnitDirectory = "units/"
        RuntimeDataDirectory = "var/#{ZeroinitDirectory}"
        TemporaryDirectory = "tmp/#{ZeroinitDirectory}"
        SettingDirectory = "etc/#{ZeroinitDirectory}"
        LogDirectory = "var/log/#{ZeroinitDirectory}"
        LibraryDirectory = "usr/share/#{ZeroinitDirectory}"
        UnitSettingDirectory = "#{SettingDirectory}#{UnitDirectory}"

    end

end
