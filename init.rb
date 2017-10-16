APP_ROOT = File.dirname(__FILE__)

$:.unshift( File.join(APP_ROOT, 'lib') )
require 'messages'

messages = Messages.new('messages.yaml')
messages.launch!