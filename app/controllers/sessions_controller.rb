class SessionsController < ApplicationController

    skip_before_action :authenticated, only: [:new, :create]
    before_action :current_user, only: [:new, :journal]
    def new
        render :layout => 'nofoothead'
        if logged_in?
            redirect_to @user
        end
    end

    def create
        @user = User.find_by(username: params[:username])
            if @user && @user.authenticate(params[:password])
                session[:user_id] = @user.id
                redirect_to @user
            else
                flash[:error] = "Your username or password is incorrect. Please try again"
                redirect_to login_path
            end
    end

    def destroy
        session.delete(:user_id)
        redirect_to login_path
    end
end
