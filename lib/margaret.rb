require 'file_handling'
require 'yaml'

class Margaret

    @get_messages = YAML::load_file('messages.yaml')

    def self.add_message(message)
        return false unless File_Handling.file_useable?
        # puts message
        @get_messages['Margaret'] = Array.new if @get_messages['Margaret'].nil?
        @get_messages['Margaret'] << message 
        open_file = File.open('messages.yaml', 'r+')
        open_file.puts YAML::dump(@get_messages)
        open_file.close
    end
    
end