
class UserEntity
  private_class_method :new

  attr_reader :email, :name, :id

  Error = Class.new(StandardError)
  InvalidEmailError = Class.new(Error)

  def initialize(email:, name:, id: nil)
    @email = email
    @name = name
    @id = id
  end

  class << self
    def build!(**params)
      params = params.with_indifferent_access
      validate_email!(params[:email])

      new(
        email: params[:email],
        name: params[:name],
        id: params[:id]
      )
    end

    private

    def validate_email!(email)
      raise InvalidEmailError, "email can not be blank" if email.blank?
    end
  end
end
