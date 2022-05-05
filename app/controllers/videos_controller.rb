class VideosController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:thumb_upload]
  before_action :set_video, only: %i[show edit update sync thumb thumb_upload]

  def index
    @videos = Video.order(id: :desc)
  end

  def show; end

  def edit
    @description_templates = DescriptionTemplate.all
    @presenters = Presenter.all
  end

  def update
    if @video.update(video_params)
      redirect_to @video
    else
      flash[:alert] = @video.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def sync
    service = Youtube.new(YoutubeSession.last)

    service.update_video(@video)
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
      service = Youtube.new(YoutubeSession.last)
      service.set_thumbnail(@video, file)
    ensure
      file.close
      file.unlink
    end
  end

  private

  def set_video
    @video = Video.find(params.fetch(:id))
  end

  def video_params
    params[:video][:presenter_ids] ||= []
    params
      .require(:video)
      .permit(
        :title,
        :subtitle,
        :raw_tags,
        :chapter_markers,
        :summary,
        :description_template_id,
        presenter_ids: [],
      )
  end
end
