class UserNotify < ActionMailer::Base

  def setup_email(user, sent_at, subject_key)
    @recipients = "#{user.login}"
    @from       = Messages.get_message("from", "email")
    @subject    = Messages.get_message(subject_key, "user_notify")
    @sent_on    = sent_at
    @headers['Content-Type'] = "text/plain; charset=utf-8; format=flowed"
    @body = {}
    @body["name"] = "#{user.firstname.to_s} #{user.lastname.to_s}"
    @body["login"] = user.login
  end

  def signup(user, url, sent_at = Time.now)
    setup_email(user, sent_at, "signup_subject")
    @body["url"] = url
  end

  def forgot_password(user, sent_at = Time.now)
    setup_email(user, sent_at, "forgot_password_subject")
    @body       = {}
    @from       = ''
    @sent_on    = sent_at
    @headers    = {}
  end
end
