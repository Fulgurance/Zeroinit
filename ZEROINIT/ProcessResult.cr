module ZEROINIT

    struct ProcessResult

        property output : String
        property status : Process::Status

        def initialize(@output,@status)
        end

    end

end
