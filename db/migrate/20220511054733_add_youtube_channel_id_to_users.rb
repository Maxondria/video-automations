class AddYoutubeChannelIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :youtube_channel_id, :string, null: true
  end
end
