class Order < ApplicationRecord
  self.implicit_order_column = "created_at"

  has_many :order_items
  belongs_to :user, optional: true

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

  def open?
    shipped_at.nil? && cancelled_at.nil?
  end

  def id_short
    id.slice(0,8)
  end
end
