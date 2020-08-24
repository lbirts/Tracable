class GoalsController < ApplicationController

    before_action :current_goal, only: [:show, :edit, :update, :cheer, :destroy]
    before_action :current_user, only: [:create, :update, :destroy]
    before_action :all_categories, only: [:new, :edit]

    def index
        @goals = Goal.all
        @trend = Goal.trending
    end

    def show
        # byebug
        @comh = @goal.completed_habits
        @progh = @goal.habits_in_progress
        @percentage = @goal.habit_percentage_done
    end

    def new
        @goal = Goal.new
        @goal.habits.build
        @goal.habits.build
        @goal.habits.build
    end

    def create
        @goal = Goal.new(goal_params.merge(user_id: @user.id))
        if !params[:goal][:id_category].blank?
            new_category = Category.create(title: params[:goal][:id_category])
            @goal.category_id = new_category.id
            @new_journal = Journal.create(entry: "You created the #{new_category.title} category", user_id: session[:user_id])
        end
        if @goal.save
            redirect_to @goal 
            @new_journal = Journal.create(entry: "You created #{@goal.title} goal", user_id: session[:user_id])
        else
            flash[:errors] = @goal.errors.full_messages
            redirect_to new_goal_path
        end
       
    end

    def edit
    end

    def update
        if !@goal.complete
            if @goal.user.id == @user.id
                @goal.update(goal_params)
                redirect_to @goal
                @new_journal = Journal.create(entry: "You updated #{@goal.title} goal", user_id: session[:user_id])
            else
                flash[:user] = "You do not have access to edit this goal"
                redirect_to edit_goal_path
            end
        else
            flash[:com] = "You cannot edit a completed goal"
            redirect_to edit_goal_path
        end 
    end

    def destroy
        if @goal.user_id == @user.id
            @goal.destroy
            redirect_to user_path(@user)
        else
            flash[:user] = "You do not have access to delete this goal"
            redirect_to goal_path
        end
    end
    
    def cheer
        @goal.add_cheer
        @goal.save
        redirect_to goal_path
        @new_journal = Journal.create(entry: "You cheered on #{@goal.title} goal", user_id: session[:user_id])
    end

    def complete_goal
        @goal = Goal.find(params[:goal_id])
        @goal.completed_it
        @goal.save
        redirect_to user_path
        @new_journal = Journal.create(entry: "You completed #{@goal.title} goal", user_id: session[:user_id])
    end

    def current_goal
        @goal = Goal.find(params[:id])
    end

    def all_categories
        @categories = Category.all
    end

    private

    def goal_params
        params.require(:goal).permit(:title, :description, :category_id, :due_date, :cheers, :complete, habits_attributes: [:name, :description, :complete])
    end
end
