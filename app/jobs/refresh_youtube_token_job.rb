class RefreshYoutubeTokenJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)

    unless user.youtube_sessions.empty?
      session = user.youtube_sessions.last

      service = Youtube.new(session)
      refreshed_token = service.refresh_token

      # merge with existing token
      credentials =
        JSON
          .parse(session.credentials)
          .merge(
            access_token: refreshed_token['access_token'],
            expires_at: Time.now.to_i + refreshed_token['expires_in'],
          )

      session.update!(credentials: credentials.to_json) and return
    end

    return
  end
end
