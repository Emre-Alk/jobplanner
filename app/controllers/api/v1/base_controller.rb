class Api::V1::BaseController < ActionController::Api

  private

  def verfiy_auth_token
    @user = User.find_by(token: params[:token])
    if @user.nil?
      raise StandardError.new "you don't have a valid token"
    end
  end
end
