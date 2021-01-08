require './lib/json_web_token.rb'

module Api
  class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authorize_request, except: [:create, :login]

  def index
    @users = User.all

    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      render json: {message: "data has been deleted"}, status: 	:ok
    else
      render status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(email: user_params[:email])
    if BCrypt::Password.new(@user.password) == user_params[:password]
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), email: @user.email }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      rescue Mongoid::Errors::DocumentNotFound => e
        render json: { errors: 'User not found' }, status: :not_found
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :password, :fullname, :birthday, :roles, :location_id)
    end

  end
end