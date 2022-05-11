# == Schema Information
#
# Table name: youtube_sessions
#
#  id            :uuid             not null, primary key
#  session_token :string           not null
#  credentials   :json
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :uuid             not null
#
class YoutubeSession < ApplicationRecord
  before_validation(on: :create) { self.session_token ||= SecureRandom.uuid }

  belongs_to :user
end
