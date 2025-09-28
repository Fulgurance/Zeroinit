module ZEROINIT

    module Path

        ZeroinitDirectory = "zeroinit/"
        BinaryDirectory = "sbin/"
        UnitDirectory = "units/"
        RuntimeDataDirectory = "var/#{ZeroinitDirectory}"
        TemporaryDirectory = "tmp/#{ZeroinitDirectory}"
        LogsDirectory = "var/log/#{ZeroinitDirectory}"
        LibraryDirectory = "usr/lib/#{ZeroinitDirectory}"
        SettingDirectory = "#{RuntimeDataDirectory}settings/"
        UnitSettingDirectory = "#{SettingDirectory}#{UnitDirectory}"

    end

end
