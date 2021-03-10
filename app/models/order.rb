class Order < ApplicationRecord
  attr_accessor :promo_code

  self.implicit_order_column = "created_at"

  has_many :order_items, dependent: :destroy
  belongs_to :user, optional: true

  before_validation :update_status!
  before_destroy :confirm_shopping

  validates :status, presence: true

  scope :fulfillment, -> { where(status: 'Fulfillment') }

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

  def apply_promo_code!(code)
    order_items.promo.destroy_all
    promo = Admin::Promotion.active.find_by(code: code)
    if promo
      if promo.discount_percentage.present? && promo.discount_percentage != 0
        order_items.create(item_type: 'Promo', amount: gross_amount * -promo.discount_percentage/100.0, promo_code: code)
      elsif promo.discount_dollars.present? && promo.discount_dollars != 0
        order_items.create(item_type: 'Promo', amount: -promo.discount_dollars, promo_code: code)
      end
      if promo.has_free_shipping?
        order_items.shipping.first.update(amount: 0)
      end
      true
    else
      false
    end
  end

  def weight_oz
    order_items.joins(:product).sum(:size_oz)
  end

  def apply_shipping!
    shipping_item = order_items.find_or_create_by(item_type: 'Shipping')
    shipping_item.update(amount: Shipping.new(self).amount)
  end

  def apply_taxes!
    tax_item = order_items.find_or_create_by(item_type: 'Taxes')
    tax_item.update(amount: Tax.new(self).amount)
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
