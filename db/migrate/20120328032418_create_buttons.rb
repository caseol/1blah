class CreateButtons < ActiveRecord::Migration
  def change
    create_table :buttons do |t|
      t.string :title
      t.text :description
      t.string :media_file_name
      t.string :media_content_type
      t.integer :media_file_size
      t.datetime :media_updated_at
      t.integer :category_id

      t.timestamps
    end
  end
end
