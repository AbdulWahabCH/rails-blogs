class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :edit, :update, :destroy ]
  before_action :set_comment, except: [ :new, :create ]

  def show
  end

  def edit
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      create_notification(@comment)
      redirect_to @article, notice: "Comment was successfully created."
    else
      redirect_to @article, alert: "Error creating comment."
    end
  end

  def update
    if @comment.update(comment_params)
        respond_to do |format|
          format.html { redirect_to @article }
          format.turbo_stream
        end
    else
        render :edit
    end
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
      flash[:alert] = "Comment is deleted"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def set_comment
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
  
  def create_notification(comment)
    notification = Notification.build(
      user: comment.article.user,
      actor: current_user,
      notifiable: comment,
      action: :commented,
      status: :unread
    )
    notification.save
  end
end
