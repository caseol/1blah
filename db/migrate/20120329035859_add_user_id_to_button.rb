class AddUserIdToButton < ActiveRecord::Migration
  def change
    add_column :buttons, :user_id, :integer
  end
end
