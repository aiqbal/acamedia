class UserNotify < ActionMailer::Base
  def signup(user, password, url=nil)
    setup_email(user)

    # Email header info
    @subject += "Welcome to #{UserSystem::CONFIG[:app_name]}!"

    # Email body substitutions
    @body["name"] = "#{user.firstname} #{user.lastname}"
    @body["login"] = user.login
    @body["password"] = password
    @body["url"] = url || UserSystem::CONFIG[:app_url].to_s
    @body["app_name"] = UserSystem::CONFIG[:app_name].to_s
    @body = render_message("user_notify/signup", @body)
  end

  def forgot_password(user, url=nil)
    setup_email(user)

    # Email header info
    @subject += "Forgotten password notification"

    # Email body substitutions
    @body["name"] = "#{user.firstname} #{user.lastname}"
    @body["login"] = user.login
    @body["url"] = url || UserSystem::CONFIG[:app_url].to_s
    @body["app_name"] = UserSystem::CONFIG[:app_name].to_s
    @body = render_message("user_notify/forgot_password", @body)
  end

  def change_password(user, password, url=nil)
    setup_email(user)

    # Email header info
    @subject += "Changed password notification"

    # Email body substitutions
    @body["name"] = "#{user.firstname} #{user.lastname}"
    @body["login"] = user.login
    @body["password"] = password
    @body["url"] = url || UserSystem::CONFIG[:app_url].to_s
    @body["app_name"] = UserSystem::CONFIG[:app_name].to_s
    @body = render_message("user_notify/change_password", @body)
  end

  def pending_delete(user, url=nil)
    setup_email(user)

    # Email header info
    @subject += "Delete user notification"

    # Email body substitutions
    @body["name"] = "#{user.firstname} #{user.lastname}"
    @body["url"] = url || UserSystem::CONFIG[:app_url].to_s
    @body["app_name"] = UserSystem::CONFIG[:app_name].to_s
    @body["days"] = UserSystem::CONFIG[:delayed_delete_days].to_s
    @body = render_message("user_notify/pending_delete", @body)
  end

  def delete(user, url=nil)
    setup_email(user)

    # Email header info
    @subject += "Delete user notification"

    # Email body substitutions
    @body["name"] = "#{user.firstname} #{user.lastname}"
    @body["url"] = url || UserSystem::CONFIG[:app_url].to_s
    @body["app_name"] = UserSystem::CONFIG[:app_name].to_s
    @body = render_message("user_notify/delete", @body)
  end

  def setup_email(user)
    @recipients = "#{user.login}"
    @from       = UserSystem::CONFIG[:email_from].to_s
    @subject    = "[#{UserSystem::CONFIG[:app_name]}] "
    @sent_on    = Time.now
    @headers['Content-Type'] = "text/plain; charset=#{UserSystem::CONFIG[:mail_charset]}; format=flowed"
  end
end
