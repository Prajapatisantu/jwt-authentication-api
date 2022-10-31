class ApplicationController < ActionController::Base
  include JwtToken
  before_action :authenticate_user

  private

  def authenticate_user
    if request.headers['Authorization'].present?
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        @decoded = JwtToken.jwt_decode(header)
        if @decoded[:exp] > Time.now.to_i
          @current_user = User.find_by(id: @decoded[:user_id])
        else
          render json: {errors: "Token is expired"}, status: 401
        end
      rescue ActiveRecord::RecordNotFound => e
        render json: {errors: e.message}, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: {errors: e.message}, status: :unauthorized
      end
    end
  end
end
