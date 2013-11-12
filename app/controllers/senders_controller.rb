class SendersController < ApplicationController
  def create
    @sender = Sender.create(sender_params)
  end

private

  def sender_params
    params.require(:sender).permit(:name, :email)
  end
end
