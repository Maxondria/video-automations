class VideosController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:thumb_upload]
  before_action :set_video, only: %i[show edit update sync thumb thumb_upload]

  def index
    @videos = current_user.videos.order(id: :desc)
  end

  def show; end

  def edit
    @description_templates = current_user.description_templates.all
    @categories = current_user.categories.all
    @presenters = current_user.presenters.all
  end

  def update
    if @video.update(video_params)
      redirect_to @video
    else
      flash.now[:alert] = @video.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def sync
    unless current_user.youtube_sessions.empty?
      service = Youtube.new(current_user.youtube_sessions.last)
      service.update_video(@video)
    end

    redirect_back(fallback_location: root_path)
  end

  def thumb; end

  def thumb_upload
    # Extract the base64 encoded image
    img = params[:thumbnail]['data:image/png;base64,'.length..-1]
    decoded_img = Base64.decode64(img)

    file = Tempfile.new([Time.now.to_i.to_s, '.png'])
    file.binmode
    file.write(decoded_img)
    file.rewind

    begin
      unless current_user.youtube_sessions.empty?
        service = Youtube.new(current_user.youtube_sessions.last)
        service.set_thumbnail(@video, file)
      end
    ensure
      file.close
      file.unlink
    end
  end

  private

  def set_video
    @video = current_user.videos.find(params.fetch(:id))
  end

  def video_params
    params[:video][:presenter_ids] ||= []
    params
      .require(:video)
      .permit(
        :title,
        :category_id,
        :raw_tags,
        :chapter_markers,
        :summary,
        :description_template_id,
        presenter_ids: [],
      )
  end
end
