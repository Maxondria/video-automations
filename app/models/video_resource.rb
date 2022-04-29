# == Schema Information
#
# Table name: video_resources
#
#  id         :uuid             not null, primary key
#  url        :string           not null
#  title      :string           not null
#  video_id   :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class VideoResource < ApplicationRecord
  belongs_to :video
end
