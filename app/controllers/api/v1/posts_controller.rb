class Api::V1::PostsController < Api::V1::BaseController
  # with this heritage, the user is authentified by token and available as @user
  before_action :verfiy_auth_token

  def create
    content = params[:content] #recup depuis l'extension
    url = params[:url] #recup depuis l'extension
    scrap = Scraper.new
    post = Post.create(url: url, scraper: scrap, user: @user) #creer le post avec url only et assignation current user
    OpenAiJob.perform_later(post.id)

    # #recup depuis chatgpt fake
    # response = {
    #   title: "ingenieur",
    #   comment: "done",
    #   company_name: "edf"
    # }
  end
end
