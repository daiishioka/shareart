class Artpost < ApplicationRecord
  belongs_to :user
  mount_uploader :artimage, ImageUploader
  
  validates :artimage, presence: true
end
