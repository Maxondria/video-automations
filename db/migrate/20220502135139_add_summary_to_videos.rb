class AddSummaryToVideos < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :summary, :text
  end
end
