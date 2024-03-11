class PostsController < ApplicationController
  def index
    @posts = Post.all
    @user = current_user
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
  end

  def edit
  end

  def update
  end

  def render_post_partial
    @post = Post.find(params[:id])
    TablepostChannel.broadcast_to(
      current_user,
      {
        message: "partial",
        post_id: @post.id,
        html: render_to_string(partial: "posts/post", locals: { post: @post }, formats: :html)
      }
    )
  end
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_url, notice: "Post was successfully destroyed."
    else
      # Handle error
    end
  end
end
