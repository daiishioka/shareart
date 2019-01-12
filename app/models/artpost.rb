class Artpost < ApplicationRecord
  belongs_to :user
  mount_uploader :artimage, ImageUploader
  
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  has_many :like_users, through: :favorites, source: :user
  
  validates :artimage, presence: true
end
