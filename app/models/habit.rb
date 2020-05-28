class Habit < ApplicationRecord
    belongs_to :goal

    validates :name, presence: true, on: :create
    validates :description, presence: true, on: :create
    # validates :goal_id, presence: true
    # days it took to complete

    # how far they coming in goal completion DONE
    # maybe progress bar

    # how many habits you've completed this month 
 
    # average compltetion rate DONE

    # daily streaks??? No

    # top goals people are completing No

    #how many habits you've completed this month
        # longest streak
        # completetions in th last 30 days
        # overall completeion rate DONE

        # completions per week

    # journal
        # mood 1-10
        # productivity 1-10
        # health and strength 1-10
        # check off any habit completions
    
    # bets
        # total amount of money won

    # compled  in progress DONE

    # add goal to user No

    # n ppl have completed this goal No
    
    def completed_it
        self.complete = true
    end

    def completing_goal
        self.goal.checking_completion
    end

    def self.by_month(month)
        self.all.select { |habit|
            habit.created_at.strftime("%A, %B%e, %Y").include? month
        }.map do |h|
            h.name
        end.join(" , ")
    end


    # def update_goal
    #     @goal = Goal.find(self.goal.id)
    #     @goal.complete = self.goal.complete
    # end

end
