require 'google/api_client/client_secrets'
require 'google/apis/youtube_v3'

class Youtube
  def initialize(session)
    @session = session
  end

  def fetch_videos(&block)
    next_page_token = nil

    loop do
      page =
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

      page.items.each { |item| block.(item) } if block_given?

      next_page_token = page.next_page_token

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
      end
  end
end
