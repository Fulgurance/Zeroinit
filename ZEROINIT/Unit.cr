module ZEROINIT

  class Unit
    
    include JSON::Serializable

    property name : String
    property description : String
    property dependencies : Array(String)

    def initialize( @name = String.new,
                    @description = String.new,
                    @dependencies = Array(String).new)
    end

    def self.loadConfiguration(path : String)
        begin
            return from_json(File.read(path))
        end
    end

    def writeConfiguration(path : String)
        finalPath = path.chomp(path[path.rindex("/")..-1])

        if !Dir.exists?(finalPath)
            Dir.mkdir_p(finalPath)
        end

        file = File.open(path,"w")
        to_json(file)
        file.close

        rescue error

    end

  end

end
