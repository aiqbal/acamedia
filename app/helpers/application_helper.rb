# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def get_error_messages(obj_name)
    obj = self.instance_variable_get "@#{obj_name}"
    errors_message = error_messages_for(obj_name)
    obj.errors.clear
    return errors_message
  end

  def get_stylesheets
    files = []
    stylesheet_root = "#{RAILS_ROOT}/public/stylesheets/"
    possible_files = [controller.controller_name, "#{controller.controller_name}/#{controller.action_name}"]
    possible_files.each do |file_name|
      path = "#{stylesheet_root}#{file_name}.css"
      files << file_name if File.exists?(path)
    end
    return files
  end
end
