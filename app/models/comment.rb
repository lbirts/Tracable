class Comment < ApplicationRecord
    belongs_to :goal
    belongs_to :user

    validates :content, presence: true, uniqueness: { scope: :user_id}

    def self.newest
        self.all.sort {|a,b|
            b.created_at <=> a.created_at
        }.first
    end

    def self.longest
        self.all.max_by { |comment|
            comment.content.length
        }
    end
end
