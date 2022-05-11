# == Schema Information
#
# Table name: categories
#
#  id             :uuid             not null, primary key
#  name           :string           not null
#  title_color    :string           default("#F72585"), not null
#  subtitle_color :string           default("#C2F7EB"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :uuid             not null
#
class Category < ApplicationRecord
  has_many :videos, dependent: :destroy
  belongs_to :user
end
