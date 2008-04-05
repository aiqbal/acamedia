# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def get_error_messages(obj_name)
    obj = self.instance_variable_get "@#{obj_name}"
    errors_message = error_messages_for(obj_name)
    obj.errors.clear
    return errors_message
  end
end
