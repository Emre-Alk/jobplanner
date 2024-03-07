class Api::V1::BaseController < ActionController::API

  private

  def verfiy_auth_token
    @user = User.find_by(token: params[:token])
    if @user.nil?
      render json: { message: 'unauthorized: unknown user' }, status: 401
    end
  end
end
