# app/controllers/admin/comments_controller.rb
class Admin::CommentsController < Admin::BaseController
  before_action :set_comment, only: [ :show, :update, :destroy ]

  # GET /admin/comments
  def index
    comments = Comment.all
    render json: comments, status: :ok
  end

  # GET /admin/comments/:id
  def show
    render json: @comment, status: :ok
  end

  # POST /admin/comments
  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/comments/:id
  def update
    if @comment.update(comment_params)
      render json: @comment, status: :ok
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /admin/comments/:id
  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :article_id, :user_id)
  end
end
