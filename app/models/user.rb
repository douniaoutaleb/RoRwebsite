class User < ActiveRecord::Base

	before_save { self.email = email.downcase }

	validates :nom, presence: true, length: {maximum: 50}
	validates :prenom, presence: true, length: {maximum: 50}
	validates :etablissement, presence: true, length: {maximum: 100}
	validates :identifiant, presence: true, length: {maximum: 100},uniqueness:{ case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }
	validates :user_type, presence: true, length: { maximum: 2 }

	VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length:{maximum: 255},format: {with: VALID_EMAIL},uniqueness:{ case_sensitive: false }

	has_secure_password
end
