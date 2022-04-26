class AddDescriptionTemplateToVideos < ActiveRecord::Migration[7.0]
  def change
    add_reference :videos,
                  :description_templates,
                  null: false,
                  foreign_key: true,
                  type: :uuid
  end
end
