class PackagesController < ApplicationController
  def new
    @package = Package.new
  end

  def create
    @package = Package.new(package_params)
    if @package.save
      flash[:notice] = 'Files Sent! Check your email for the share code'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @package = Package.find(params[:id])
    unless @package.authenticate(params[:token])
      flash[:alert] = 'Access denied'
      redirect_to home_path
    end
  end

private

  def package_params
    params.require(:package).permit(:message,
                                    :user_email,
                                    :user_name,
                                    :recipient_email,
                                    attachments_attributes: [:file, :_destroy])
  end
end
