# == Schema Information
#
# Table name: description_templates
#
#  id         :uuid             not null, primary key
#  template   :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class DescriptionTemplate < ApplicationRecord
  has_many :videos, dependent: :nullify
end
