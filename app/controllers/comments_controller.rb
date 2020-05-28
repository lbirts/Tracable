class CommentsController < ApplicationController

    before_action :current_comment, only: [:show, :edit, :update]
    
    def show
    end

    def new 
        @comment = Comment.new
        @goals = Goal.all
    end

    def create
        @comment = Comment.create(comment_params.merge(user_id: session[:user_id]))
        if @comment.save
            redirect_to @comment.goal
            @new_journal = Journal.create(entry: "You commented on #{@comment.goal.title} goal", user_id: session[:user_id])
        else
            flash[:errors] = @comment.errors.full_messages
            redirect_to @comment.goal
        end
        
    end

    def edit
        @goals = Goal.all
    end

    def update
        @comment.update(comment_params)
        redirect_to @comment
        @new_journal = Journal.create(entry: "You updated your comment on #{@comment.goal.title}", user_id: session[:user_id])
    end

    def current_comment
        @comment = Comment.find(params[:id])
    end

    private

    def comment_params
        params.require(:comment).permit(:content, :goal_id)
    end

end
