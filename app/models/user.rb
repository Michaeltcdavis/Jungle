class User < ApplicationRecord
  has_secure_password
  validates :password, presence: true, length: {minimum: 8}
  validates :password_confirmation, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  def self.authenticate_with_credentials email, password
    formatted_email = email.downcase.strip
    user = User.find_by_email(formatted_email)
    if user && user.authenticate(password)
      return user
    end
    return nil
  end
end
