class Item < ApplicationRecord
  belongs_to :merchant

  def self.active_items
    where(status: true)
  end
end
