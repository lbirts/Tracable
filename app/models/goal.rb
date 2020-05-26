class Goal < ApplicationRecord
    has_many :habits
    has_many :comments
    belongs_to :user
    belongs_to :category
end
