class CreateUser
  attr_reader :token
  private :token

  DEFAULT_EMAIL = "user@example.com"

  def initialize(token)
    @token = token
  end

  def call
    User.create!(default_params)
  end

  private

  def default_params
    {
      email: email,
      password: password,
      authentication_token: token
    }
  end

  def email
    "#{password}_#{DEFAULT_EMAIL}"
  end

  def password
    @password ||= SecureRandom.hex(10)
  end

end
