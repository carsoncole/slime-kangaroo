class Order < ApplicationRecord
  self.implicit_order_column = "created_at"

  has_many :order_items

  before_destroy :confirm_pending

  def confirm_pending
    errors.add(:base, 'Can not be destroyed') unless pending?
  end

  def status
    if refunded_at.present?
      'Refunded'
    elsif cancelled_at.present?
      'Cancelled'
    elsif shipped_at.present?
      'Shipped'
    elsif charged_at.present?
      'Fulfillment'
    else
      "Pending"
    end
  end

  def pending?
    status == 'Pending'
  end

  def open?
    shipped_at.nil? && cancelled_at.nil?
  end
end
