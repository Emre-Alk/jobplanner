class Api::V1::PostsController < Api::V1::BaseController
  # with this heritage, the user is authentified by token and available as @user
  before_action :verfiy_auth_token

  def create
    content = params[:content] #recup depuis l'extension
    url = params[:url] #recup depuis l'extension
    post = Post.new(url:, scrap_status: 'initializing', user: @user, html_source: content) #creer le post avec url only et assignation current user
    if post.save
      TablepostChannel.broadcast_to(
        @user,
        {
          message: "partial",
          post_id: post.id,
          html_table_row: render_to_string(partial: "posts/post", locals: { post:, form: false }, formats: :html),
          html_chart: false
        }
      )
      OpenAiJob.perform_later(post.id, @user)
      render json: { message: 'created' }, status: 201
    else
      render json: { message: 'Unprocessable Entity' }, status: 422
    end
  end
end
