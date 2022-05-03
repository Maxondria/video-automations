module VideosHelper
  def video_embed(video)
    content_tag(
      :iframe,
      '',
      src: "https://www.youtube.com/embed/#{video.youtube_id}",
      width: 560,
      height: 315,
      frameborder: 0,
      allowfullscreen: true,
      allow:
        'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture',
    )
  end
end
