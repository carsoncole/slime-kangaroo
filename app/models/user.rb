class User < ApplicationRecord
  include Clearance::User

  has_many :orders

  def name
    (first_name || '') + ' ' + (last_name || '')
  end
end
