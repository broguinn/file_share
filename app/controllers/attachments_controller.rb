class AttachmentsController < ApplicationController
  def show
    @attachment = Attachment.find(params[:id])
    if @attachment.package.authenticate(params[:token])
      @attachment.send_sender_email
      #'https://s3-us-west-2.amazonaws.com/file-share-argon/attachments/files/000/000/015/original/04_Let_it_Go_Nah.mp3'
      #'http://s3.amazonaws.com/file-share-argon/attachments/files/000/000/015/original/04_Let_it_Go_Nah.mp3?1384455498'
      puts @attachment.file.url
      data = open @attachment.file.url
      send_data data.read, filename: @attachment.file_file_name, type: @attachment.file_content_type
    else
      flash[:alert] = 'You don\'t have permission to view those files!'
      redirect_to home_path
    end
  end

private

  def attachment_params
    params.require(:attachment).permit(:file)
  end
end
