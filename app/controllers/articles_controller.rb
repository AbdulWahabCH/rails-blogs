class ArticlesController < ApplicationController
  include EmbeddingConcern
    before_action :authenticate_user!, only: [ :create, :edit, :new, :destroy, :update ]
    before_action :add_article, only: [ :edit, :show, :destroy, :update ]


    def index
      if params[:query].present?
        query_embedding = generate_embeddings(params[:query])
        @articles =  Article.order(Arel.sql("embeddings <=> '#{query_embedding}'")).limit(2)
      else
        @articles = Article.all.order(created_at: :desc)
      end
    end

    def show
    end

    def new
      @article = Article.new
    end

    def edit
    end
    def create
      @article = current_user.articles.build(article_params)
      @article.embeddings = generate_embeddings(@article.body)
      if @article.save
        make_collabs(@article, params[:co_authors])
        redirect_to @article, notice: "Article was successfully created."
      else
        render :new
      end
    end


    def update
      if @article.update(article_params)
        redirect_to @article, notice: "Comment was successfully updated."
      else
        render :edit
      end
    end


    def destroy
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
    def make_collabs(article, co_authors)
      # this is just to create a default colab for the owner as an owner
      article.collaborations.create(user: current_user, role: :owner)
      if co_authors.present? && co_authors.is_a?(Array)
        co_authors.each do |co_author_id|
          article.collaborations.create(user_id: co_author_id, role: :co_author)
        end
      end
    end
    def add_article
      @article = Article.find(params[:id])
    end
end
