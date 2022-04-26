class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos, id: :uuid do |t|
      t.string :youtube_id, null: false
      t.string :title, null: false
      t.string :tags, array: true, default: []
      t.text :chapter_markers

      t.timestamps
    end

    add_index :videos, :youtube_id, unique: true
  end
end
