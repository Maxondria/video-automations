namespace :youtube do
  task fetch_videos: :environment do
    User.all.each do |user|
      next if user.youtube_sessions.empty?

      service = Youtube.new(user.youtube_sessions.last)
      category = user.categories.first
      description_template = user.description_templates.last

      service.fetch_videos do |external_video|
        snippet = external_video.snippet
        id = external_video.id

        video = Video.find_or_initialize_by(youtube_id: id)
        video.title = snippet.title
        video.tags = snippet.tags || []
        video.summary = snippet.description
        video.category = category
        video.description_template = description_template
        video.user = user
        video.save!
      end
    end
  end
end
