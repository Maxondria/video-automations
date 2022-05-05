class AddSubtitleToVideos < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :subtitle, :string
  end
end
