require 'file_handling'
require 'margaret'
require 'mary'
require 'yaml'

class Messages

    class Config
        @@actions = ["list", "add", "quit"]
        def self.actions; @@actions; end
    end

    def initialize(path=nil)
        File_Handling.filepath = path
        if File_Handling.file_useable?
            puts "Found Messages File."
        elsif File_Handling.create_file
            puts "Created Messages File."
        else 
            puts "Exiting. \n\n"
            return :quit
        end
    end

    def launch!
        introduction

        puts "What would you like to do? " + Messages::Config.actions.join(", ")

        result = nil
        until result == :quit do
            action, args = get_action
            result = do_action(action, args)
        end
        
        conclusion
    end

    def get_action
        action = nil
        until Messages::Config.actions.include?(action)
            puts "Stuff You Can Do: " + Messages::Config.actions.join(", ") if action
            print "> "
            user_response = gets.chomp
            args = user_response.downcase.strip.split(' ')
            action = args.shift
        end

        return action, args
    end

    def do_action(action, args=[])
        case action
            when 'list'
                list
            when 'add'
                add
            when 'quit'
                return :quit
            else
                puts "I don't understand that command"
        end
    end

    def add
        puts "Add a Message!"
        newmessage = File_Handling.add_messages_with_interface
        if newmessage.save
            puts "New Message Added"
        else
            puts "SAVE ERROR: Message not added"
        end
    end

    def list()
        puts "Listing All Messages!"
        array = []
        $/="\n\n"
        File.open('messages.yaml', "r").each do |object|
          array << YAML::load(object)
        end
        puts array
    end

    def introduction
        puts "\n\n<<< Welcome to the Mary and Margaret Message App! >>>\n\n"
        puts "LET'S GET STARTED!\n\n"
    end
    def conclusion
        puts "\n<<< Nice Chatting! TTYL! >>>\n\n\n"
    end

end