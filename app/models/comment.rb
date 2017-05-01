class Comment < ApplicationRecord
  validates :content, null: false, allow_blank: false
  belongs_to :product
  belongs_to :user
end
