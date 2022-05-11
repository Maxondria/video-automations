class AddUserIdToPresenters < ActiveRecord::Migration[7.0]
  def change
    add_reference :presenters,
                  :user,
                  null: false,
                  foreign_key: true,
                  type: :uuid
  end
end
