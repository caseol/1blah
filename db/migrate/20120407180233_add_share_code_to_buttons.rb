class AddShareCodeToButtons < ActiveRecord::Migration
  def change
    add_column :buttons, :share_code, :string
  end
end
