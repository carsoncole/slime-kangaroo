class Tax
  def initialize(order)
    @amount = if order.state == 'WA'
      promo_item = order.order_items.promo.first
      (order.gross_amount + (promo_item&.amount || 0)) * 0.090
    else
      0.0
    end
  end

  def amount
    @amount
  end
end
