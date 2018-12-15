class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :city
      t.string :state
      t.timestamps
    end
  end
end
