class AuthenticationController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user, only: [:login]

  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JwtToken.jwt_encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: {token: token, exp: time.strftime("%m-%d-%y %H:%M"), username: @user.user_name}, status: :ok
    else
      render json: {error: 'unauthorized request'}, status: :unauthorized
    end
  end

  def checking_list
    render json: {user: @current_user}, status: 200
  end

end
