class UsersController < ApplicationController
  def index
    users = User.all

    render json: users.as_json
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user.as_json, status: :ok
    else
      render json: { errors: user.errors.as_json }
    end
  end

  def update
    user = User.find(params[:id])

    if user.update(user_params)
      render json: user.as_json, status: :ok
    else
      render json: { errors: user.errors.as_json }
    end
  end

  private

  def user_params
    params.permit(:name, :email)
  end
end
