# app/controllers/admin/articles_controller.rb
class Admin::ArticlesController < Admin::BaseController
    before_action :set_article, only: [ :show, :update, :destroy, :send_warning ]
    skip_before_action :verify_authenticity_token, only: [ :send_warning ]


    # GET /admin/articles
    def index
      articles = Article.all
      render json: articles, each_serializer: ArticleSerializer, status: :ok
    end

    # GET /admin/articles/:id
    def show
      render json: @article, serializer: ArticleSerializer, status: :ok
    end

    # PATCH/PUT /admin/articles/:id
    def update
      if @article.update(article_params)
        render json: @article, status: :ok
      else
        render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # DELETE /admin/articles/:id
    def destroy
      @article.destroy
      head :no_content
    end

    def send_warning
      message = params[:message]
      warning_type = params[:warning_type]

      # Validate the parameters
      if message.blank? || warning_type.blank?
        render json: { error: "Message and warning type are required." }, status: :unprocessable_entity
        return
      end

      ArticleMailer.review_request(@article.user, @article, message).deliver_now

      render json: { message: "Warning sent successfully." }, status: :ok
    end

    private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :body, :user_id) # Adjust based on your Article model attributes
    end

  # def warning_params
  #   params.require()
  # end
end
