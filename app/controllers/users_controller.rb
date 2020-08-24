class UsersController < ApplicationController
    
    skip_before_action :authenticated, only: [:new, :create]
    before_action :current_user, only: [:show, :edit, :update, :complete_goal]
    
    def index
        @users = User.all
        
    end
    
    def edit
    end

    def update
        if @user.update(user_params)
            redirect_to @user
            @new_journal = Journal.create(entry: "You updated your account", user_id: @user.id)
        else 
            flash[:errors] = @user.errors.full_messages
            redirect_to edit_user_path
        end
    end

    def new
        render :layout => false
        if logged_in?
            redirect_to @user
        else
            @user = User.new
        end
    end

    def create
        @user = User.new(auth_params)
        byebug
        
        if @user.valid?
            @user.save
            session[:user_id] = @user.id
            redirect_to "/users/#{@user.id}/edit"
            @new_journal = Journal.create(entry: "You created an account", user_id: session[:user_id])
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to signup_path
        end
    end

    def show
        @completed = @user.sort_due_date.completed_goals
        @progress = @user.sort_due_date.goals_in_progress
        @hprogress = @user.habits_in_progress
        @featured = @user.most_likes
        @percentage = @user.goals_percentage_done
        if session[:user_id] == params[:id].to_i
            @user = User.find(session[:user_id])
        else
            redirect_to "/users/#{session[:user_id]}"
        end
    end

    def journal
        @entries = @user.journals
    end

    def destroy
        session.delete(:user_id)
        @user.destroy
        redirect_to login_path
    end

    private

    def auth_params
        params.permit(:username, :password, :password_confirmation)
    end

    def user_params
        params.require(:user).permit(:username, :name, :email, :image_url)
    end

end
