class User < ActiveRecord::Base
	has_secure_password
	has_many :reviews, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :favorite_movies, through: :favorites, source: :movie

  validates :name, presence: true
  validates :email, presence: true, format: /\A\S+@\S+\z/,  uniqueness: { case_sensitive: false }
  validates :username, presence: true, format: /\A[A-Z0-9]+\z/i, uniqueness: { case_sensitive: false }

 	def self.authenticate(email_or_username, password)
  		user = User.find_by(email: email_or_username) || User.find_by(username: email_or_username)
  		user && user.authenticate(password)
	end

end
