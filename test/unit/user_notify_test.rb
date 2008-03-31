require File.dirname(__FILE__) + '/../test_helper'

class UserNotifyTest < ActionMailer::TestCase
  tests UserNotify
  def test_signup
    @expected.subject = 'UserNotify#signup'
    @expected.body    = read_fixture('signup')
    @expected.date    = Time.now
    #UserNotify.create_signup(@user1, @expected.date)
    #assert_equal(Messages.get_message("signup_subject", "user_notify"), @subject)

    #assert_equal @expected.encoded, UserNotify.create_signup(@user1,@expected.date).encoded
  end

  def test_forgot_password
    @expected.subject = 'UserNotify#forgot_password'
    @expected.body    = read_fixture('forgot_password')
    @expected.date    = Time.now

    #assert_equal @expected.encoded, UserNotify.create_forgot_password(@expected.date).encoded
  end

end
