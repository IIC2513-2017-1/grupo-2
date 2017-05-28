class Comment < ApplicationRecord
  validates :content, null: false, allow_blank: false
  belongs_to :product
  belongs_to :user

  has_attached_file :attach
  do_not_validate_attachment_file_type :attach

end
