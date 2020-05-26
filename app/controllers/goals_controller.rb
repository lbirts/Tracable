class GoalsController < ApplicationController

    before_action :current_goal, only: [:show, :edit, :update]
    before_action :all_categories, only: [:new, :edit]

    def index
        @goals = Goal.all
    end

    def show
    end

   

    def new
        @goal = Goal.new
    end

    def create
        @goal = Goal.create(goal_params.merge(cheers: 0, complete: false, user_id: session[:user_id]))
        redirect_to @goal
    end

    def edit
    end

    def update
        @goal.update(goal_params)
        redirect_to @goal
    end

    def current_goal
        @goal = Goal.find(params[:id])
    end

    def all_categories
        @categories = Category.all
    end

    private

    def goal_params
        params.require(:goal).permit(:title, :description, :category_id, :due_date)
    end
end
