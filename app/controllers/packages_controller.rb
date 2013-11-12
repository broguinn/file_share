class PackagesController < ApplicationController
  def new
    @package = Package.new
  end

  def create
    @package = Package.create(package_params)
    flash[:notice] = 'Files Sent!'
    redirect_to root_path
  end

private

  def package_params
    params.require(:package).permit(:message,
                                    :encrypted_token,
                                    :user_email,
                                    :user_name,
                                    :sender_attributes,
                                    recipient_attributes: [:email],
                                    attachment_attributes: [:file])
  end
end
