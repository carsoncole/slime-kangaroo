class Order < ApplicationRecord
  attr_accessor :promo_code

  self.implicit_order_column = "created_at"

  has_many :order_items, dependent: :destroy
  belongs_to :user, optional: true

  before_validation :update_status!
  before_destroy :confirm_shopping

  validates :status, presence: true

  def confirm_shopping
    unless shopping?
      throw(:abort)
    end
  end

  def update_status!
    self.status = if refunded_at.present?
      'Refunded'
    elsif cancelled_at.present?
      'Cancelled'
    elsif shipped_at.present?
      'Shipped'
    elsif charged_at.present?
      'Fulfillment'
    else
      "Shopping"
    end
  end

  def apply_promo_code(code)
    promo_item = order_items.find_or_create_by(item_type: 'Promo').update(amount: -20.0, description: code)
  end

  def shopping?
    status == 'Shopping'
  end

  def shipping
    order_items.where(item_type: 'Shipping').last
  end

  def taxes
    order_items.where(item_type: 'Taxes').last
  end

  def shipping_info_provided?
    if street_address_1.present? && city.present? && state.present? && zip_code.present?
        true
    else
      false
    end
  end

  def open?
    shipped_at.nil? && cancelled_at.nil?
  end

  def id_short
    id.slice(0,8)
  end
end
