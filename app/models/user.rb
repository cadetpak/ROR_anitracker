class User < ActiveRecord::Base

# Allows user to 'own' animes, when user is destroyed anime fields destroyed
has_many :animes, dependent: :destroy
# Automatically requires presence
has_secure_password 
EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
validates :alias, :email, presence: true
validates :alias, length: { minimum: 4 }


end
