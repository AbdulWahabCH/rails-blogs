class ArticleSerializer < ActiveModel::Serializer
    attributes :id, :title, :body, :created_at, :updated_at, :reaction_count, :user

    def user
      UserSerializer.new(object.user)
    end

    def reaction_count
      {
        like: object.reaction_count("like"),
        dislike: object.reaction_count("dislike"),
        love: object.reaction_count("love")
      }
    end

    delegate :created_at, :updated_at, to: :object
end
