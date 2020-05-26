class User < ApplicationRecord
    has_many :goals
    has_many :habits, through: :goals
    has_many :comments

    has_secure_password
end
