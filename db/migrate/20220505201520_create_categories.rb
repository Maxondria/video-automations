class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :name, null: false
      t.string :title_color, null: false, default: '#F72585'
      t.string :subtitle_color, null: false, default: '#C2F7EB'

      t.timestamps
    end
  end
end
