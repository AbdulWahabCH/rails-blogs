class ReactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_object

  def like
    @reaction = Reaction.find_or_initialize_by(
      user: current_user,
      reactable: find_reactable)

      if @reaction.new_record?
        @reaction.reaction_type = "like"
        @reaction.save
        flash[:notice] = "You liked!"
      elsif @reaction.reaction_type == "unlike"
        @reaction.reaction_type = "like"
        @reaction.save
        flash[:notice] = "You updated your reaction to like!"
      else
        flash[:alert] = "You already liked this!"
      end

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_back(fallback_location: root_path) }
      end
  end


def unlike
  @reaction = Reaction.find_by(
      user: current_user,
      reactable: find_reactable
    )

    if @reaction
      if @reaction.reaction_type == "like"
        @reaction.destroy
        flash[:notice] = "You unliked the #{@type}!"
      elsif @reaction.reaction_type == "unlike"
        flash[:alert] = "You already disliked this!"
      end
    else
      # If the user has not liked it yet, create a dislike
      Reaction.create(
        user: current_user,
        reactable: find_reactable,
        reaction_type: "unlike" # Register as dislike
      )
      flash[:notice] = "You disliked the #{@type}!"
    end
  respond_to do |format|
      format.turbo_stream
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

  private

  def find_reactable
    params[:reactable_type].constantize.find(params[:reactable_id])
  end
  def get_object
    @reactable = find_reactable()
    if @reactable.is_a?(Article)
      @article = @reactable
      @type = "Article"
    elsif @reactable.is_a?(Comment) # Corrected this line
      @comment = @reactable
      @type = "Comment"
    end
  end
end
