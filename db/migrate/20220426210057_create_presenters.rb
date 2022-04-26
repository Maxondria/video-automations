class CreatePresenters < ActiveRecord::Migration[7.0]
  def change
    create_table :presenters, id: :uuid do |t|
      t.string :name, null: false
      t.string :twitter_handle
      t.string :linked_in
      t.string :role

      t.timestamps
    end
  end
end
