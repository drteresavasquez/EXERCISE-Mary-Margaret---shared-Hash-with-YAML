require 'file_handling'
require 'yaml'

class Mary

    @get_messages = YAML::load_file('messages.yaml')

    def self.add_message(message)
        return false unless File_Handling.file_useable?
        # puts message
        @get_messages['Mary'] = Array.new if @get_messages['Mary'].nil?
        @get_messages['Mary'] << message 
        open_file = File.open('messages.yaml', 'r+')
        open_file.puts YAML::dump(@get_messages)
        open_file.close
    end
    
end