class Order < ApplicationRecord
  self.implicit_order_column = "created_at"

  has_many :order_items, dependent: :destroy
  belongs_to :user, optional: true

  after_create :add_shipping_and_taxes
  before_destroy :confirm_shopping
  before_save :update_status!

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

  def shopping?
    status == 'Shopping'
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

  private

  def add_shipping_and_taxes
    order_items.create(item_type: 'Shipping', amount: 0)
    order_items.create(item_type: 'Taxes', amount: 0)
  end
end
