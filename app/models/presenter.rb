# == Schema Information
#
# Table name: presenters
#
#  id             :uuid             not null, primary key
#  name           :string           not null
#  twitter_handle :string
#  linked_in      :string
#  role           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :uuid             not null
#
class Presenter < ApplicationRecord
  has_many :video_presenters, dependent: :destroy
  has_many :videos, through: :video_presenters
  belongs_to :user

  def twitter_url
    "https://twitter.com/#{twitter_handle}" unless twitter_handle.blank?
  end
end
