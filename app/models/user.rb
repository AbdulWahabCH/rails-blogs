class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

    devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :articles, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :collaborations
    has_many :collaborated_articles, through: :collaborations, source: :article
    has_many :notifications
    has_one_attached :avatar

    before_validation :set_default_role, on: :create

    enum role: { user: 0, admin: 1 }

    def admin?
      role == "admin"
    end
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 8 }

    private
      def set_default_role
        self.role ||= :user
      end
end
