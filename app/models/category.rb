class Category < ApplicationRecord
    has_many :goals
    validates :title, presence: true, uniqueness: true

    def self.most_popular
        self.all.max_by(3) { |c|
            c.goals.length
        }
    end

    def self.top
        self.all.max_by { |c|
            c.goals.length
        }.title
    end

    def self.newest
        self.all.sort {|a,b|
            b.created_at <=> a.created_at
        }.first.title
    end

    def featured_goal
        self.goals.all.max_by { |c|
            c.cheers
        }
    end
end

