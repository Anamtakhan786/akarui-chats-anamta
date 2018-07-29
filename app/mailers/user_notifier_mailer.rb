class UserNotifierMailer < ApplicationMailer
	default :from => 'noreply@example.com'

  def notify_email(user)
    @user = user
    mail(to: @user.try(:email), subject: 'You have a message from new user')
  end
end