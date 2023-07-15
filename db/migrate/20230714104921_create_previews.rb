class CreatePreviews < ActiveRecord::Migration[7.0]
  def change
    create_table :previews do |t|
      t.string :url, null: false, unique: true
      t.string :image_url
      t.integer :status
      t.timestamps
    end
    add_index :previews, :url, unique: true
  end
end
