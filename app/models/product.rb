class Product < ApplicationRecord
  has_rich_text :description
  has_many :order_items
  validates :name, presence: true
  validates :price, numericality: {  greater_than_or_equal_to: 0, allow_nil: true }

  before_destroy :check_if_in_any_orders

  scope :master, -> { where(master_product_id: nil) }
  scope :active, -> { where(is_active: true)}

  has_many_attached :images
  belongs_to :master_product, class_name: 'User', foreign_key: 'master_product_id', optional: true

  def check_if_in_any_orders
    if order_items.any?
      errors.add(:base, 'can not be destroyed due to being used') 
      throw(:abort)
    end
  end
end
