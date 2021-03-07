class Order < ApplicationRecord
  self.implicit_order_column = "created_at"

  has_many :order_items
  belongs_to :user, optional: true

  before_destroy :confirm_pending
  before_save :update_status!

  def confirm_pending
    errors.add(:base, 'Can not be destroyed') unless pending?
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
      "Pending"
    end
  end

  def pending?
    status == 'Pending'
  end

  def open?
    shipped_at.nil? && cancelled_at.nil?
  end

  def id_short
    id.slice(0,8)
  end
end
