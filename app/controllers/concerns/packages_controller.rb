class PackagesController < ApplicationController
  def new
    @package = Package.new
  end

  def create
    @package = Package.create(package_params)
  end

private

  def package_params
    params.require(:package).permit(:message, :encrypted_token)
  end
end
