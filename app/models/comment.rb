class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :product
  belongs_to :user

  has_attached_file :attach
  do_not_validate_attachment_file_type :attach

end
