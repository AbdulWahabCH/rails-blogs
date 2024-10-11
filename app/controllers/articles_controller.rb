class ArticlesController < ApplicationController
    before_action :authenticate_user!, only: [ :create, :new, :destroy ]

    def index
      puts current_user
      @user = current_user
      @articles = Article.all.order(created_at: :desc)
    end

    def new
      @article = current_user.articles.build
    end

    def create
      @article = current_user.articles.build(article_params)
      if @article.save
        redirect_to @article, notice: "Article was successfully created."
      else
        render :new
      end
    end

    def show
      @article = Article.find(params[:id])
    end

    def destroy
        @article = Article.find(params[:id])

        if @article.user == current_user
          @article.destroy
          redirect_to articles_path, notice: "Article was successfully deleted."
        else
          redirect_to articles_path, alert: "not authorized to delete."
        end
    end

    private

    def article_params
      params.require(:article).permit(:title, :body)
    end
end
