# == Schema Information
#
# Table name: video_presenters
#
#  id           :uuid             not null, primary key
#  video_id     :uuid             not null
#  presenter_id :uuid             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class VideoPresenter < ApplicationRecord
  belongs_to :video
  belongs_to :presenter
end
