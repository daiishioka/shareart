class User < ApplicationRecord
	before_save { self.email.downcase! }
	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
	has_secure_password
	mount_uploader :image, ImageUploader
	
	has_many :artposts
	has_many :relationships
	has_many :followings, through: :relationships, source: :follow
	has_many :followers, through: :reverses_of_relationship, source: :user
	has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
	
	has_many :favorites
	has_many :likes, through: :favorites, source: :artpost
		
	def follow(other_user)
		unless self == other_user
			self.relationships.find_or_create_by(follow_id: other_user.id)
		end
	end
	
	def unfollow(other_user)
		relationship = self.relationships.find_by(follow_id: other_user.id)
		relationship.destroy if relationship
	end
	
	def following?(other_user)
		self.followings.include?(other_user)
	end
	
	def feed_artposts
		Artpost.where(user_id: self.following_ids + [self.id])
	end
	
	def like(artpost)
		self.favorites.find_or_create_by(artpost_id: artpost.id)
	end
	
	def unlike(artpost)
		like = self.favorites.find_by(artpost_id: artpost.id)
		like.destroy if like
	end
	
	def favorite?(artpost)
		self.likes.include?(artpost)
	end
	
	def followings_count
		self.followings.count
	end
	
	def followers_count
		self.followers.count
	end
	
	def self.find_or_create_from_auth(auth)
		provider = auth[:provider]
		uid = auth[:uid]
		user_name = auth[:info][:name]
		image_url = auth[:info][:image]
		twitter_url = auth[:info][:urls][:twitter]
		
		self.find_or_create_by(provider: provider, uid: uid) do |user|
			user.user_name = user_name
			user.image_url = image_url
		end
	end
	
end