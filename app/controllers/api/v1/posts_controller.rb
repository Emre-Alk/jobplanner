class PostsController < Api::V1::BaseController
  before_action :verfiy_auth_token
end
