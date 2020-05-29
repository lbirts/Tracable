class Goal < ApplicationRecord
    has_many :habits
    has_many :comments
    belongs_to :user
    belongs_to :category

    accepts_nested_attributes_for :habits

    validates :title, presence: true, on: :create
    validate :due_date_cannot_be_in_past, on: :create
    validate :days_to_make_a_habit, on: :create
    validates :due_date, presence: true, on: :create

    def due_date_cannot_be_in_past
        if due_date.present? && due_date < Date.today
            errors.add(:due_date, "cannot be in the past")
        end
    end

    def days_to_make_a_habit
        if due_date
            if (due_date - Date.today).to_i < 66
                errors.add(:due_date, ":it takes 66 days to form a habit, pick a later date")
            end
        end
    end

    def add_cheer
        self.cheers += 1
    end

    def completed_it
        self.complete = true
        self.habits.each { |h|
            h.completed_it
        }
    end

    def habit_percentage_done
        perc = (self.completed_habits.count.to_f / self.habits.count.to_f) * 100
        perc.round
    end

    def self.goal_percentage_done
        perc = (completed_goals.count.to_f / self.all.count.to_f) * 100
        perc.round
    end

    def self.goals_in_progress
        self.all.select { |g|
            g.complete == false
        }
    end

    def habits_in_progress
        self.habits.select { |g|
            g.complete == false
        }
    end

    def completed_habits
        self.habits.select { |h|
            h.complete == true
        }
    end

    def self.completed_goals
        self.all.select { |g|
            g.complete == true
        }
    end

    def completed?
        if self.complete == true
            "Completed by #{self.user.username}"
        else
            "Created by #{self.user.username}"
        end
    end

    def checking_completion
        if self.habits.all? { |hab| hab.complete == true}
            self.complete = true
        end
    end

    def days_left
        if due_date
            (due_date - Date.today).to_i
        end
    end

    def date_format
        self.due_date.strftime("%A, %B %e, %Y")
    end

    def self.trending
        self.all.max_by(5) { |g|
            g.cheers
        }
    end

    def trending?(arr)
       arr.include?(self)
    end

    def self.most_cheers
        self.all.max_by { |g|
            g.cheers
        }
    end

    def self.most_cheers_and_comments
        self.all.max_by { |g|
            g.cheers + g.comments.length
        }
    end
    

    def self.most_comments
        self.all.max_by(5) { |g|
            g.comments.length
        }
    end

    def self.top_comments
        self.all.max_by { |g|
            g.comments.length
        }
    end

    def self.least_cheer
        self.all.min_by { |g|
            g.cheers
        }
    end

    def self.least_comments
        self.all.max_by { |g|
            g.comments.length
        }
    end


    def self.total_habits
        Habit.all.count
    end

    def self.average_number_of_habits
        (total_habits.to_f/Goal.all.count).round(2)
    end

    def self.average_cheers
        (self.all.count / self.total_cheers).round(2)
    end

    def self.average_comments
        (self.all.count / self.total_comments).round(2)
    end

    def self.total_cheers
        total = 0
        Goal.all.each { |g|
            total += g.cheers
        }
        total
    end

    def self.total_comments
        total = 0
        Goal.all.each { |g|
            total += g.comments.count
        }
        total
    end

    def due_soon
        if days_left && self.days_left > 0
            self.days_left < 14
        end
    end

    def past_due
        if days_left && self.complete == false
            self.days_left < 0
        end
    end

    def self.all_due_soon
        due = self.all.select { |goal|
            goal.due_soon
        }.map do |g|
            g.title
        end.join(" , ")
    end

    def self.all_past_due
        self.all.select { |goal|
            goal.past_due
        }.map do |g|
            g.title
        end.join(" , ")
    end

    def self.by_month(month)
        self.all.select { |goal|
            goal.created_at.strftime("%A, %B%e, %Y").include? month
        }.map do |g|
            g.title
        end.join(" , ")
    end

    def self.latest
        self.all.sort {|a,b|
            b.created_at <=> a.created_at
        }.first
    end

    def self.sort_due_date
        self.order(due_date: :desc)
    end
    
    
end
