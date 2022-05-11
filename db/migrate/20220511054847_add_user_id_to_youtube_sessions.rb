class AddUserIdToYoutubeSessions < ActiveRecord::Migration[7.0]
  def change
    add_reference :youtube_sessions,
                  :user,
                  null: false,
                  foreign_key: true,
                  type: :uuid
  end
end
