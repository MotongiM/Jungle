class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true

  
  def self.authenticate_with_credentials(email, password)  # class methods have self.
    user = User.find_by_email(email.strip.downcase)
    if user && user.authenticate(password) # authenticate comes from the has_secure_password gem
      user
    else
      nil
    end
  end
end