class CategoriesController < ApplicationController

    before_action :current_category, only: [:show, :edit, :update]
    
    def index
        @categories = Category.all
        @top = Category.most_popular
    end

    def show
        @featured = @category.featured_goal
    end

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            redirect_to @category
            @new_journal = Journal.create(entry: "You created the #{@category.title} category", user_id: session[:user_id])
        else
            flash[:errors] = @category.errors.full_messages
            redirect_to new_category_path
        end
        
    end

    def edit 
    end

    def update
        @category.update(category_params)
        redirect_to @category
        @new_journal = Journal.create(entry: "You updated the #{@category.title} category", user_id: session[:user_id])
    end

    def current_category
        @category = Category.find(params[:id])
    end

    private

    def category_params
        params.require(:category).permit(:title)
    end
end
