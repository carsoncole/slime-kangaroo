class Admin::Promotion < ApplicationRecord
  validates :code, format: { with: /\A[a-zA-Z0-9]+\z/,
    message: "only allows letters and numbers" }
  validates :name, length: { maximum: 20 }
  validates :starts_at, presence: true
  validate :check_only_percentage_or_dollar

    scope :active, -> { where("admin_promotions.starts_at < ? AND admin_promotions.ends_at > ?", Time.now, Time.now) }

  def active?
    self.starts_at < Time.now && !expired?
  end

  def expired?
    self.ends_at.present? && self.ends_at < Time.now
  end

  private

  def check_only_percentage_or_dollar
    errors.add(:base, 'only 1 of percentage or a dollar discount is allowed') if discount_percentage.present? && discount_dollars.present?
  end
end
