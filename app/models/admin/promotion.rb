class Admin::Promotion < ApplicationRecord
  validates :code, format: { with: /\A[a-zA-Z0-9]+\z/,
    message: "only allows letters and numbers" }
  validates :name, length: { maximum: 20 }

    scope :active, -> { where("admin_promotions.start < ? AND admin_promotions.end > ?", Time.now, Time.now) }

  def active?
    self.start < Time.now && self.end > Time.now
  end

  def expired?
    self.end < Time.now
  end
end
