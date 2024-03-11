class PostsController < ApplicationController

  def index
    @posts = Post.all
    @user = current_user
    set_posts_per_day(@posts)
    set_status_frequency(@posts)
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
    
  private

  def set_posts_per_day(posts)
    posts_per_day = {}
    posts.each do |post|
      date = post.created_at.strftime("%Y-%m-%d")
      if posts_per_day[date]
        posts_per_day[date] += 1
      else
        posts_per_day[date] = 1
      end
    end
    @posts_per_day = posts_per_day
  end

  def set_status_frequency(posts)
    status_frequency = {}
    posts.each do |post|
      status = post.status
      if status_frequency[status]
        status_frequency[status][:count] += 1
      else
        status_frequency[status] = { count: 1, color: post.color }
      end
    end
    @status_frequency = status_frequency
  end
end
