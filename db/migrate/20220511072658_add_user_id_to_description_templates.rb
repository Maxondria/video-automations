class AddUserIdToDescriptionTemplates < ActiveRecord::Migration[7.0]
  def change
    add_reference :description_templates,
                  :user,
                  null: false,
                  foreign_key: true,
                  type: :uuid
  end
end
