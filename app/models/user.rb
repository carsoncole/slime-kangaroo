class User < ApplicationRecord
  include Clearance::User

  has_many :orders

  def name
    (first_name || '') + ' ' + (last_name || '')
  end

  def pending_order
    orders.where(status: 'Pending').last
  end
end
