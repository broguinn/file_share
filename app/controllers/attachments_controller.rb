class AttachmentsController < ApplicationController
  def create
    binding.pry
    @attachment = Attachment.create(attachment_params)
    render :nothing
  end

private

  def attachment_params
    params.require(:attachment).permit(:file)
  end
end
