class Purchase < ApplicationRecord
  validates :name, presence: true
  validates :cost, numericality: { greater_than: 0 }
end
