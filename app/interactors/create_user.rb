class CreateUser
  attr_reader :uid
  private :uid

  DEFAULT_EMAIL = "user@example.com"

  def initialize(uid)
    @uid = uid
  end

  def call
    User.where(authentication_token: uid).first_or_create!(default_params)
  end

  private

  def default_params
    {
      email: email,
      password: password
    }
  end

  def email
    "#{password}_#{DEFAULT_EMAIL}"
  end

  def password
    @password ||= SecureRandom.hex(10)
  end
end
