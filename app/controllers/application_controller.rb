class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?
    before_action :authenticated
    skip_before_action :authenticated, only: [:home]

    def current_user
        if session[:user_id]
            @user = User.find(session[:user_id])
        end
    end

    def logged_in?
        !!current_user
    end

    def authenticated
        redirect_to login_path unless logged_in?
    end

    def home
    end
end
