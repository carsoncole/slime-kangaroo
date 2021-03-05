class Order < ApplicationRecord
  has_many :order_items

  scope :open, -> { where(shipped_at: nil, cancelled_at: nil)}

  def open?
    shipped_at.nil? && cancelled_at.nil?
  end
end
