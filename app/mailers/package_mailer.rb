class PackageMailer < ActionMailer::Base
  default from: "from@example.com"

  def sender_email(package, token)
    @user = package.user_email
    @url = 
  end

  def recipient_email(package, token)

  end
end
