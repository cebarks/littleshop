class Merchant < ApplicationRecord
  validates_presence_of :name, :city, :state
end
