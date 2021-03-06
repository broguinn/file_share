class PackageMailer < ActionMailer::Base
  default from: "fileshare@example.com"

  def recipient_email(package, token)
    @package = package
    @token = token
    mail(to: package.recipient_email, subject: 'Your File Share Package is Ready')
  end

  def sender_email(package)
    @package = package
    mail(to: package.user_email, subject: 'Your Files Were Accessed')
  end
end
