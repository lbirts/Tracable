class HabitsController < ApplicationController

    before_action :current_habit, only: [:show, :edit, :update]
    before_action :all_goals_for_user, only: [:new, :edit]

    def show
    end

    def new
        @habit = Habit.new
    end

    def create
        @habit = Habit.create(habit_params.merge(complete: false))
        redirect_to @habit
    end

    def edit
    end

    def update
        @habit.update(habit_params)
        redirect_to @habit
    end

    def current_habit
        @habit = Habit.find(params[:id])
    end

    def all_goals_for_user
        @goals = Goal.where(user_id: session[:user_id])
    end

    private

    def habit_params
        params.require(:habit).permit(:name, :description, :goal_id)
    end

end
