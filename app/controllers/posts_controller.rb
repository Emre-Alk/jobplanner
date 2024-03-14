class PostsController < ApplicationController

  def index
    @user = current_user
    @posts = current_user.posts
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
    @post = Post.find(params[:id])
    @posts = current_user.posts

    respond_to do |format|
      format.html
      format.json do
        status = params[:content]
        @post.status = status

        if @post.save
          render json: { html_status: render_to_string(partial: "posts/status", locals: { post: @post }, formats: :html) }
          set_posts_per_day(@posts)
          set_status_frequency(@posts)
          TablepostChannel.broadcast_to(
          current_user,
          {
            message: "partial",
            post_id: @post.id,
            html_table_row: render_to_string(partial: "posts/post", locals: { post: @post }, formats: :html),
            html_chart: render_to_string(partial: "components/stats", locals: {posts_per_day: @posts_per_day, status_frequency: @status_frequency}, formats: :html)
          }
        )
        else
          render status: '400'
        end
      end
      format.text do
        puts "✅✅✅✅✅✅✅✅✅✅✅✅"
        puts "#{form_params[:comment]}"
        puts "✅✅✅✅✅✅✅✅✅✅✅✅"
        if @post.update(form_params)
          render partial: "posts/comment", locals: { post: @post }, formats: [:html]
        else
          render plain: "couldn't update note"
        end
      end
    end
  end

  def render_post_partial
    @post = Post.find(params[:id])
    @posts = current_user.posts
    set_posts_per_day(@posts)
    set_status_frequency(@posts)
    TablepostChannel.broadcast_to(
      current_user,
      {
        message: "partial",
        post_id: @post.id,
        html_table_row: render_to_string(partial: "posts/post", locals: { post: @post }, formats: :html),
        html_chart: render_to_string(partial: "components/stats", locals: {posts_per_day: @posts_per_day, status_frequency: @status_frequency}, formats: :html)
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

  def sort
    column = params[:column]
    direction = params[:direction]

    @posts = current_user.posts.order("#{column} #{direction}")

    render json: { html_table: render_to_string(partial: "posts/tbody", locals: { posts: @posts }, formats: :html) }
  end

  private

  def set_posts_per_day(posts)
    posts = posts.where(status: 'candidaté')
    posts_per_day = {}
    posts.each do |post|
      date = post.updated_at.strftime("%Y-%m-%d")
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

  def form_params
    params.require(:post).permit(:comment)
  end
end
