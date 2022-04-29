class AddNameToDescriptionTemplates < ActiveRecord::Migration[7.0]
  def change
    add_column :description_templates, :name, :string, null: false
  end
end
