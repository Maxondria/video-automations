class YoutubeSession < ApplicationRecord
  before_validation(on: :create) { self.session_token ||= SecureRandom.uuid }
end
