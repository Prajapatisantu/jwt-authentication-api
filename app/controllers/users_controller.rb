class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user, only: [:create]
    before_action :find_user, only: [:show, :update, :destroy]

    def index
      @users = User.all
      render json: @users, status: 200
    end
    
    def create
      @user = User.create(user_params)
      if @user.save
        render json: @user, status: 201
      else
        render json: {errors: @user.errors.full_messages }, status: 503
      end
    end
    
    def update
    
    end
    
    def show
      render json: @user, status: 200
    end
    
    def destroy
      @user.destroy
    end

  private

    def user_params
      params.permit(:user_name, :name, :email, :password)
    end

    def find_user
      @user = User.find_by(id: params[:id])
    end
end
