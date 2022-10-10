class UsersController < ApplicationController
  UnprocessableEntityError = Class.new(StandardError)

  def index
    users = UserRepository.all

    render json: users.map(&method(:serialize))
  end

  def create
    handle_bad_request do
      user = handle_validate_errors do
        UserEntity.build!(**user_params)
      end
      UserRepository.persist!(user)
    end
  end

  def update
    user = UserRepository.find!(params[:id])

    handle_bad_request do
      user = handle_validate_errors do
        user = UserEntity.build!(
          id: user.id,
          **user_params
        )
      end
      UserRepository.persist!(user)
    end
  end

  private

  def user_params
    params.permit(:name, :email)
  end

  def serialize(user)
    {
      id: user.id,
      name: user.name,
      email: user.email
    }
  end

  def handle_validate_errors
    yield
  rescue UserEntity::Error => error
    raise UnprocessableEntityError, error.message
  end

  def handle_bad_request
    user = yield
    render json: serialize(user)
  rescue UnprocessableEntityError => error
    render json: { error: error.message }, status: :unprocessable_entity
  end
end
