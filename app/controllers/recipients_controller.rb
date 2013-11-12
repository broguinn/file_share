class RecipientsController < ApplicationController
  def create
    @recipient = Recipient.create(recipient_params)
  end

private

  def recipient_params
    params.require(:recipient).permit(:email)
  end
end
