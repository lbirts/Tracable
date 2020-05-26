class CommentsController < ApplicationController

    before_action :current_comment, only: [:show, :edit, :update]
    
    def show
    end

    def new 
        @comment = Comment.new
        @goals = Goal.all
    end

    def create
        @comment = Comment.new(comment_params.merge(user_id: session[:user_id]))
        redirect_to @comment
    end

    def edit
        @goals = Goal.all
    end

    def update
        @comment.update(comment_params)
        redirect_to @comment
    end

    def current_comment
        @comment = Comment.find(params[:id])
    end

    private

    def comment_params
        params.require(:comment).permit(:content, :goal_id)
    end

end
