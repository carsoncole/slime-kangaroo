class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product, optional: true

  before_save :update_amount!, if: Proc.new {|oi| oi.product? }
  after_save :update_order_amount!
  after_destroy :update_order_amount!

  scope :product, -> { where(item_type: 'Product') }
  scope :non_product, -> { where.not(item_type: 'Product') }
  scope :promo, -> { where(item_type: 'Promo') }


  def product?
    item_type == 'Product'
  end

  def shipping?
    item_type == 'Shipping'
  end

  def taxes?
    item_type == 'Taxes'
  end

  def promo?
    item_type == 'Promo'
  end

  def tax_shipping_promo_description
    case item_type
    when 'Promo'
      "Promo (#{description})"
    else
      item_type
    end
  end

  private

  def update_amount!
    self.amount = quantity * unit_price
  end

  def update_order_amount!
    order.update(gross_amount: order.order_items.product.sum(:amount), net_amount: order.order_items.sum(:amount))
  end
end
