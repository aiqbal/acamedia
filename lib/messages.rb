class Messages
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

  def self.get_message(message_name, class_name)
    self.load_message if GLOBAL_MESSAGES.empty?
    return GLOBAL_MESSAGES[class_name][message_name] if GLOBAL_MESSAGES[class_name]
  end
end
