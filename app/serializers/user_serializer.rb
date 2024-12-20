class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :role, :avatar_url, :post_count, :comment_count, :created_at

  def avatar_url
    object.avatar.attached? ? Rails.application.routes.url_helpers.rails_blob_url(object.avatar, only_path: true) : nil
  end

  def post_count
    object.articles.count
  end

  def comment_count
    object.comments.count
  end

  delegate :created_at, to: :object
end
