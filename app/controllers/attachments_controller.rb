class AttachmentsController < ApplicationController
  def create
    @attachment = Attachment.create(attachment_params)
    render :nothing
  end

private

  def attachment_params
    params.require(:attachment).permit(:file)
  end
end
