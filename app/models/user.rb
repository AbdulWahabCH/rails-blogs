class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

    devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :articles, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :collaborations, dependent: :destroy
    has_many :collaborated_articles, through: :collaborations, source: :article
    has_many :notifications, dependent: :destroy
    has_one_attached :avatar, dependent: :destroy

    before_validation :set_default_role, on: :create
    before_destroy :purge_avatar

    enum role: { user: 0, admin: 1 }

    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 8 }


    def admin?
      role == "admin"
    end

    private
      def set_default_role
        self.role ||= :user
      end

      def purge_avatar
        if avatar.attached?
          avatar.purge_later
          # avatar.variant_records.each(&:purge)
        end
      end
end
