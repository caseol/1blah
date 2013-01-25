class CreateCounts < ActiveRecord::Migration
  def change
    create_table :counts do |t|
      t.integer :button_id
      t.integer :value

      t.timestamps
    end
  end
end
