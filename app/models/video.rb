# == Schema Information
#
# Table name: videos
#
#  id                      :uuid             not null, primary key
#  youtube_id              :string           not null
#  title                   :string           not null
#  tags                    :string           default([]), is an Array
#  chapter_markers         :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  description_template_id :uuid             not null
#  summary                 :text
#  category_id             :uuid             not null
#
class Video < ApplicationRecord
  belongs_to :description_template
  belongs_to :category
  has_many :video_presenters, dependent: :destroy
  has_many :presenters, through: :video_presenters
  has_many :video_resources, dependent: :destroy

  def description
    erb_template =
      ERB.new(description_template.template, trim_mode: nil, eoutvar: '_erbout')

    erb_template.result(binding)
  end

  def thumb_svg
    img_template =
      File.read(
        File.join(Rails.root, 'app', 'views', 'videos', 'thumb-base.svg.erb'),
      )

    erb_template = ERB.new(img_template, trim_mode: nil, eoutvar: '_erbout')
    erb_template.result(binding)
  end

  def raw_tags=(raw_tags)
    self.tags = raw_tags.split(',').map(&:strip)
  end
end
