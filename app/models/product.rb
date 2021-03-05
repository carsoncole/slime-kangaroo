class Product < ApplicationRecord
  has_many :order_items
  validates :name, presence: true
  validates :price, numericality: {  greater_than_or_equal_to: 0, allow_nil: true }

  scope :active, -> { where(is_active: true)}

  has_many_attached :images
end
