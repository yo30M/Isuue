class Post < ApplicationRecord

  acts_as_taggable_on :tags

  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  validates :address, presence: true
  validates :comfort, presence: true
  validates :environment, presence: true

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("address LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("address LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("address LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("address LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
end
