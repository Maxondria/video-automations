class VideosController < ApplicationController
  def index
    @videos = Video.order(id: :desc)
  end

  def show
    @video = Video.find(params.fetch(:id))
  end

  def edit
    @video = Video.find(params.fetch(:id))
    @description_templates = DescriptionTemplate.all
    @presenters = Presenter.all
  end

  def update
    @video = Video.find(params.fetch(:id))

    if @video.update(video_params)
      redirect_to @video
    else
      flash[:alert] = @video.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def sync
    video = Video.find(params.fetch(:id))
    service = Youtube.new(YoutubeSession.last)

    service.update_video(video)
    redirect_back(fallback_location: root_path)
  end

  private

  def video_params
    params[:video][:presenter_ids] ||= []
    params
      .require(:video)
      .permit(
        :title,
        :raw_tags,
        :chapter_markers,
        :summary,
        :description_template_id,
        presenter_ids: [],
      )
  end
end
