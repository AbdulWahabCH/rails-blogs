class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :reactions, as: :reactable

  has_many :collaborations, dependent: :destroy

  has_many :collaborators, through: :collaborations, source: :user
  has_many :notifications, as: :notifiable

  validates :title, presence: true
  validates :body, presence: true

  scope :posted_in_last_24_hours, -> { where(created_at: 24.hours.ago..) }
  scope :search_by_title, ->(query) { where("lower(title) LIKE ?", "%#{query.downcase}%") }

  def reaction_count(type)
    reactions.where(reaction_type: type).count
  end
end
