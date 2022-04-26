class CreateVideoResources < ActiveRecord::Migration[7.0]
  def change
    create_table :video_resources, id: :uuid do |t|
      t.string :url, null: false
      t.string :title, null: false
      t.references :video, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
