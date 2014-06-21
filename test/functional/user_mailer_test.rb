require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "reset_passwort_request" do
    mail = UserMailer.reset_passwort_request
    assert_equal "Reset passwort request", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
