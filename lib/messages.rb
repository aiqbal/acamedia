module Messages
  GLOBAL_MESSAGES = {}
  MESSAGES_DIR = RAILS_ROOT + "/app/messages/"

  def self.load_message
    return unless GLOBAL_MESSAGES.empty?

    Dir[MESSAGES_DIR + '*.yml'].each do |filename|
      filename =~ /.+\/(.+).yml/
      hash = YAML::load(File.read(filename))
      GLOBAL_MESSAGES[$1] = hash
    end 
  end

  def get_message(message_name, controller_name = nil)
    controller = controller_name || params[:controller]
    return GLOBAL_MESSAGES[controller][message_name] if GLOBAL_MESSAGES[controller]
  end
  self.load_message
end
