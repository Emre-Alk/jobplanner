class PostsController < ApplicationController
  def index
    @posts = Post.all
    @user = current_user
  end

  def show
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
end
