class User < ApplicationRecord
  include Clearance::User

  has_many :orders

  before_destroy :check_if_any_orders

  def name
    (first_name || '') + ' ' + (last_name || '')
  end

  def shopping_order
    orders.where(status: 'Shopping').last
  end

  private

  def check_if_any_orders
    if orders.any?
      errors.add(:base, 'Can not destroy a user if they have orders')
      throw(:abort)
    end
  end
end
