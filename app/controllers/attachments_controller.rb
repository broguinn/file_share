class AttachmentsController < ApplicationController
  def show
    @attachment = Attachment.find(params[:id])
    send_data @attachment.file.url, type: @attachment.file_content_type
  end

private

  def attachment_params
    params.require(:attachment).permit(:file)
  end
end
