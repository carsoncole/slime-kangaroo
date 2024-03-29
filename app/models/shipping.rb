class Shipping
  def initialize(order)
    @order = order
  end

  def order
    @order
  end

  def amount
    if order.zip_code == '98110' && order.state == 'WA'
      0
    else
      case order.weight_oz
      when 0...9
        6.75
      when 9..100
        9.50
      end
    end
  end
end
