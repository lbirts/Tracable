class UsersController < ApplicationController
    
    skip_before_action :authenticated, only: [:new, :create]
    before_action :current_user, only: [:edit, :update]
    
    def index
        @users = User.all
    end

    def show
    end
    
    def edit
    end

    def update
        @user.update(user_params)
        redirect_to @user
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(auth_params)
        
        if @user.valid?
            @user.save
            session[:user_id] = @user.id
            redirect_to "/users/#{session[:user_id]}/edit"
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to signup_path
        end
    end

    def show
        # if session[:user_id] == params[:id].to_i
        #     @user = User.find(session[:user_id])
        # else
        #     redirect_to "/users/#{session[:user_id]}"
        # end
    end

    def current_user
        if session[:user_id]
            @user = User.find(session[:user_id])
        end
    end

    private

    def auth_params
        params.permit(:username, :password, :password_confirmation)
    end

    def user_params
        params.require(:user).permit(:username, :name, :email, :image_url)
    end

end
