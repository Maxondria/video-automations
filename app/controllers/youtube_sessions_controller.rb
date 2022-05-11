require 'google/api_client/client_secrets'

class YoutubeSessionsController < ApplicationController
  def new
    redirect_to(auth_client.authorization_uri.to_s, allow_other_host: true)
  end

  def callback
    auth_client.code = params[:code]
    auth_client.fetch_access_token!
    auth_client.client_secret = nil

    temp_session = YoutubeSession.new(credentials: auth_client.to_json)
    service = Youtube.new(temp_session)

    users_channel = service.fetch_channel

    if current_user.youtube_channel_id.blank?
      current_user.update!(youtube_channel_id: users_channel&.id)
    elsif current_user.youtube_channel_id != users_channel&.id
      flash[:alert] = 'You are not authorized to access this channel.'
      redirect_to(root_path) and return
    end

    # store the auth client credentials in the database
    current_user.youtube_sessions << temp_session

    redirect_to(root_path) and return
  end

  def auth_client
    @_auth_client ||=
      begin
        client_secrets =
          Google::APIClient::ClientSecrets.new(
            {
              'web': {
                'client_id':
                  Rails.application.credentials.dig(:youtube, :client_id),
                'project_id': 'video-automation-348719',
                'auth_uri': 'https://accounts.google.com/o/oauth2/auth',
                'token_uri': 'https://oauth2.googleapis.com/token',
                'auth_provider_x509_cert_url':
                  'https://www.googleapis.com/oauth2/v1/certs',
                'client_secret':
                  Rails.application.credentials.dig(:youtube, :client_secret),
                'redirect_uris': [redirect_uri],
              },
            },
          )

        auth_client = client_secrets.to_authorization
        auth_client.update!(
          scope: 'https://www.googleapis.com/auth/youtube.force-ssl',
          redirect_uri: redirect_uri,
          additional_parameters: {
            access_type: 'offline',
            include_granted_scopes: true,
          },
        )
        auth_client
      end
  end

  def redirect_uri
    url_for(action: 'callback', controller: 'youtube_sessions')
  end
end
