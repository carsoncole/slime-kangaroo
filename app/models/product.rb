class Product < ApplicationRecord
  has_many :order_items
  validates :name, presence: true
  validates :price, numericality: {  greater_than_or_equal_to: 0, allow_nil: true }

  before_destroy :check_if_used

  scope :active, -> { where(is_active: true)}

  has_many_attached :images

  def check_if_used
    errors.add(:base, 'can not be destroyed due to being used') if order_items.any?
  end
end
