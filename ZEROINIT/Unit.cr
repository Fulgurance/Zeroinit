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

        def start
        end

        def stop
        end

    end

end
