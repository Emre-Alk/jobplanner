class Api::V1::PostsController < Api::V1::BaseController
  # with this heritage, the user is authentified by token and available as @user
  before_action :verfiy_auth_token

  def create
    content = params[:content] #recup depuis l'extension

    #recup depuis chatgpt
    response = {
      title: "ingenieur",
      comment: "done",
      company_name: "edf"
    }

    @company = Company.find_or_create_by(name: response[:company_name])

    response.delete(:company_name) #retirer company du retour chatgpt afin d'utiliser response solo pour créer post
    @post = Post.new(response)
    @post.user = @user
    @post.company = @company


    if @post.save
      # QueryAiJob.perform_later # cours de demain
      render_ok
    else
      render_error
    end
  end

  private

  def render_error
    render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
  end

  def render_ok
    render json: { message: "created" }, status: '201'
  end
end
