class User < ApplicationRecord
    has_many :goals
    has_many :habits, through: :goals
    has_many :comments
    has_many :journals

    has_secure_password

    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }, on: :update
    validates :name, presence: true, on: :update
    validates :image_url, allow_blank: true, format: { 
        :with => %r{.(gif|jpg|png)\Z}i, 
        :message => "must have an image extension"
    }, on: :update
   
    validates :username, uniqueness: true

    validates :password, length: {
        minimum: 6,
        message: 'must contain at least 6 characters'
    }, on: :create
    validates :password, format: { 
        with: /\p{Upper}/,
        message: "must contain at least one uppercase"
    }, on: :create
    validates :password, format: { 
        with: /\p{Lower}/,
        message: "must contain at least one lowercase"
    }, on: :create
    validates :password, format: { 
        with: /\A(?=.*?[0-9])/x,
        message: "must contain at least one number"
    }, on: :create
    validates :password, format: { 
        with: /\A(?=.*[[:^alnum:]])/x,
        message: "must contain a special character"
    }, on: :create
    
    # PASSWORD_FORMAT = /\A
    #     (?=.{8,})          # Must contain 8 or more characters
    #     (?=.*\d)           # Must contain a digit
    #     (?=.*[a-z])        # Must contain a lower case character
    #     (?=.*[A-Z])        # Must contain an upper case character
    #     (?=.*[[:^alnum:]]) # Must contain a symbol
    # /x

    # validates :password, format: {
    #     with: PASSWORD_FORMAT,
    #     message:  "must contain 8 or more characters, a digit, a lower case character, an upper case character, and a symbol"
    # }

    def completed_goals
        self.goals.select { |g|
            g.complete == true
        }
    end

    def goals_in_progress
        self.goals.select { |g|
            g.complete == false
        }
    end

    def habits_in_progress
        self.habits.select { |h|
            h.complete == false
        }
    end

    def most_likes
        self.goals.max_by { |g|
            g.cheers
        }
    end

    def least_likes
        self.goals.min_by { |g|
            g.cheers
        }
    end

    def least_comments
        self.goals.min_by { |g|
            g.cheers
        }
    end

    def most_comments
        self.goals.max_by { |g|
            g.comments.count
        }
    end

    def goals_percentage_done
        if self.completed_goals.count > 0
            perc = (self.completed_goals.count.to_f / self.goals.count.to_f) * 100
            perc.round
        else
            perc = 0
        end
    end

    def self.total_goals
        Goal.all.count
    end

    def self.average_number_of_goals
        (total_goals.to_f/User.count).round(2)
    end

    def self.least_active
        self.all.min_by { |user|
            user.goals.count
        }
    end
    
    def self.most_active
        self.all.max_by { |user|
            user.goals.count
        }
    end

    def sort_due_date
        self.goals.order(due_date: :asc)
    end
    
end
