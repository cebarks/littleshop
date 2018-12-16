class AddsStatusToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :status, :boolean, :default => true
  end
end
