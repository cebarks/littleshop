class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :image_url
      t.integer :inventory_qty
      t.integer :price
      t.timestamps
    end
  end
end
