class RemoveSubtitleFromVideos < ActiveRecord::Migration[7.0]
  def change
    remove_column :videos, :subtitle
  end
end
