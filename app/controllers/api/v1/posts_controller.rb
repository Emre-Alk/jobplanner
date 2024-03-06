class Api::V1::PostsController < Api::V1::BaseController
  # with this heritage, the user is authentified by token and available as @user
  before_action :verfiy_auth_token

  def create
    content = params[:content] #recup depuis l'extension
    url = params[:url] #recup depuis l'extension
    post = Post.new(url: url, scrap_status: 'initializing', user: @user, html_source: content) #creer le post avec url only et assignation current user
    if post.save
      OpenAiJob.perform_later(post.id)
      render json: {status: 201, message: 'cool'}
    else
      render json: {status: 422, message: 'pas cool'}
    end


    # #recup depuis chatgpt fake
    # response = {
    #   title: "ingenieur",
    #   comment: "done",
    #   company_name: "edf"
    # }

  end
end
