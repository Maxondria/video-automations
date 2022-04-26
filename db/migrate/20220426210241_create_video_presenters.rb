class CreateVideoPresenters < ActiveRecord::Migration[7.0]
  def change
    create_table :video_presenters, id: :uuid do |t|
      t.references :video, null: false, foreign_key: true, type: :uuid
      t.references :presenter, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :video_presenters, %i[video_id presenter_id], unique: true
  end
end
