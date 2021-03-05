class Setting < ApplicationRecord
  has_rich_text :about_me
  has_rich_text :home_page_introduction
end
