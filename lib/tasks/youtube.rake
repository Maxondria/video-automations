namespace :youtube do
  task fetch_videos: :environment do
    service = Youtube.new(YoutubeSession.last)

    service.fetch_videos do |external_video|
      snippet = external_video.snippet
      id = external_video.id.video_id

      video = Video.find_or_initialize_by(youtube_id: id)
      video.title = snippet.title
      video.description_template = DescriptionTemplate.last
      video.save!
    end
  end
end
