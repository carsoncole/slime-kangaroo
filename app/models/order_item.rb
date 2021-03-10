class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product, optional: true

  validates :item_type, presence: true

  before_save :update_amount!, if: Proc.new {|oi| oi.product? }
  after_save :update_order_gross_and_net_amount!
  after_destroy :update_order_gross_and_net_amount!

  scope :product, -> { where(item_type: 'Product') }
  scope :non_product, -> { where.not(item_type: 'Product') }
  scope :promo, -> { where(item_type: 'Promo') }
  scope :taxes, -> { where(item_type: 'Taxes') }
  scope :shipping, -> { where(item_type: 'Shipping') }

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
    when 'Shipping'
      'Shipping (USPS)'
    else
      item_type
    end
  end

  def update_amount!
    self.amount = quantity * unit_price
  end

  def update_order_gross_and_net_amount!
    order.update(gross_amount: order.order_items.product.sum(:amount), net_amount: order.order_items.sum(:amount))
  end
end
