class Message < ApplicationRecord
  validates :email, presence: true
  validates :content, presence: true

  scope :unread, -> { where.not(is_read: true) }

  def unread?
    is_read == false
  end
end
