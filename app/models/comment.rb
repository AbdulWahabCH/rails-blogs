class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  has_many :reactions, as: :reactable
  has_many :notifications, as: :notifiable

  validates :content, presence: true

  def reaction_count(type)
    reactions.where(reaction_type: type).count
  end
end
