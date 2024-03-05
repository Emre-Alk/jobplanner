class Api::V1::PostsController < Api::V1::BaseController
  # with this heritage, the user is authentified by token and available as @user
  before_action :verfiy_auth_token

  def create
    puts "😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀"
    p params

    @post = Post.new(post_params)
    @post.user = @user
    @company = Company.new(name: "framatome")
    @post.company = @company

    if post.save
      # QueryAiJob.perform_later # cours de demain
      puts 'ok'
      render json: { status: 200, message: 'ok' }
    else
      puts 'nok'
      render json: { status: 422, message: post.errors.full_messages.to_sentence }
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :token)
  end
end
