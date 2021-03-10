class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product, optional: true

  validates :item_type, presence: true

  before_save :update_amount!, if: Proc.new {|oi| oi.product? }
  after_save :update_order_gross_and_net_amount!
  after_save :update_shipping!, if: Proc.new {|oi| oi.product? }
  after_save :update_taxes!, if: Proc.new {|oi| oi.product? }
  after_destroy :update_order_gross_and_net_amount!

  scope :product, -> { where(item_type: 'Product') }
  scope :non_product, -> { where.not(item_type: 'Product') }
  scope :promo, -> { where(item_type: 'Promo') }
  scope :taxes, -> { where(item_type: 'Taxes') }

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
      promo = Admin::Promotion.find_by(code: promo_code)
      "Promo: #{promo_code}"
    else
      item_type
    end
  end

  private

  def update_taxes!
    tax_item = order.order_items.find_or_create_by(item_type: 'Taxes')
    tax_item.update(amount: Tax.new(order).amount)
  end

  def update_shipping!
    shipping_item = order.order_items.find_or_create_by(item_type: 'Shipping')
    shipping_item.update(amount: Shipping.new.amount)
  end

  def update_amount!
    self.amount = quantity * unit_price
  end

  def update_order_gross_and_net_amount!
    order.update(gross_amount: order.order_items.product.sum(:amount), net_amount: order.order_items.sum(:amount))
  end
end
