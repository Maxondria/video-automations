class VideoRecordingsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def new; end

  def create
    unless current_user.youtube_sessions.empty?
      service = Youtube.new(current_user.youtube_sessions.last)

      video =
        service.upload_video(
          video_recording_params[:file].tempfile,
          video_recording_params[:title],
          video_recording_params[:description],
        )

      render json: video and return
    end

    flash.now[:alert] =
      'No YouTube sessions found for your account, please authenticate first.'

    render :new
  end

  private

  def video_recording_params
    params.require(:video_recording).permit(:title, :description, :file)
  end
end
