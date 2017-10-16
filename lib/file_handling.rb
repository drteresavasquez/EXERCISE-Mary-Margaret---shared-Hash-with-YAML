class File_Handling

    @@filepath = nil
    
    def self.filepath=(path=nil)
    @@filepath = File.join(APP_ROOT, path)
    end
    
    attr_accessor :name, :message

    def self.file_exists?
    if @@filepath && File.exists?(@@filepath)
        return true
    else
        return false
    end
    end
    
    def self.file_useable?
    return false unless @@filepath
    return false unless File.exists?(@@filepath)
    return false unless File.readable?(@@filepath)
    return false unless File.writable?(@@filepath)
    return true
    end

    def self.create_file
    File.open(@@filepath, 'w') unless file_exists?
    return file_useable?
    end

    def initialize(args={})
        @name = args[:name] || ""
        @message = args[:message] || ""
    end

    def import_line(line)
        line_array = line.split("\t")
        @name, @message = line_array
        return self
    end

    def self.add_messages_with_interface
        args = {}
        print "Who are you? (Mary or Margaret) "
        args[:name] = gets.chomp.upcase.strip
        
        print "What is your message? "
        args[:message] = gets.chomp.upcase.strip
        
        return self.new(args)
    end

    def save
        if @name == "MARY"
            Mary.add_message(@message)
            return true
        elsif @name == "MARGARET"
            Margaret.add_message(@message)
            return true
        else
            puts "That person doesn't exist or you misspelled the name options"
            return false
        end

    end
end
