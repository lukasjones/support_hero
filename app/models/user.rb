class User < ActiveRecord::Base
	has_many :day_assignments

	validates :name, :email, :password_digest, presence: true
end
