require 'google/api_client/client_secrets'
require 'google/apis/youtube_v3'

class Youtube
  def initialize(session)
    @session = session
  end

  def fetch_videos(&block)
    next_page_token = nil

    loop do
      search_results_page =
        service.list_searches(
          'snippet',
          for_mine: true,
          type: 'video',
          max_results: 50,
          page_token: next_page_token,
          order: 'date',
          options: {
            authorization: auth_client,
          },
        )

      video_ids = search_results_page.items.map { |item| item.id.video_id }

      videos_page =
        service.list_videos(
          'snippet',
          id: video_ids.join(','),
          options: {
            authorization: auth_client,
          },
        )

      videos_page.items.each { |item| block.(item) } if block_given?

      next_page_token = search_results_page.next_page_token

      break if next_page_token.nil?
    end
  end

  def update_video(video)
    external_video =
      Google::Apis::YoutubeV3::Video.new(
        id: video.youtube_id,
        snippet:
          Google::Apis::YoutubeV3::VideoSnippet.new(
            description: video.description,
            title: video.title,
            tags: video.tags,
            category_id: 27, # Education,
          ),
      )

    service.update_video(
      'snippet',
      external_video,
      options: {
        authorization: auth_client,
      },
    )
  end

  def set_thumbnail(video, file)
    service.set_thumbnail(
      video.youtube_id,
      upload_source: file,
      content_type: 'image/png',
      options: {
        authorization: auth_client,
      },
    )
  end

  private

  def service
    @service ||= Google::Apis::YoutubeV3::YouTubeService.new
  end

  def auth_client
    @auth_client ||=
      begin
        credentials =
          JSON
            .parse(@session.credentials)
            .merge(
              client_secret:
                Rails.application.credentials.dig(:youtube, :client_secret),
            )

        auth_client = Signet::OAuth2::Client.new(credentials)
        auth_client.update!(additional_parameters: { access_type: 'offline' })
        auth_client
      end
  end
end
