class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :edit, :update, :destroy ]
  before_action :set_comment, except: [ :new, :create ]
  def show
  end
  def update
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @article, notice: "Comment was successfully updated."
    else
      render :edit
    end
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @article, notice: "Comment was successfully created."
    else
      redirect_to @article, alert: "Error creating comment."
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      flash[:alert] = "Comment is deleted"
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
  end

  private
    def set_comment
      @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
    end
    def comment_params
      params.require(:comment).permit(:content)
    end
end
