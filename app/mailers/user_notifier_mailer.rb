class UserNotifierMailer < ApplicationMailer
	default :from => 'noreply@example.com'

  def notify_email(user)
    @user = user
    @url  = 'https://pacific-castle-98685.herokuapp.com/'
    mail(to: @user.email, subject: 'You have a message from new user')
  end
end
