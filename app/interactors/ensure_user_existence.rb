class EnsureUserExistence
  attr_reader :uuid
  private :uuid

  DEFAULT_EMAIL = "user@example.com"

  def initialize(uuid)
    @uuid = uuid
  end

  def call
    User.where(uuid: uuid).first_or_create!(user_params)
  end

  private

  def user_params
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
