class CategoriesController < ApplicationController

    before_action :current_category, only: [:show, :edit, :update]
    
    def index
        @categories = Category.all
    end

    def show
    end

    def new
        @category = Category.new
    end

    def create
        @category = Category.create(category_params)
        redirect_to @category
    end

    def edit 
    end

    def update
        @category.update(category_params)
        redirect_to @category
    end

    def current_category
        @category = Category.find(params[:id])
    end

    private

    def category_params
        params.require(:category).permit(:title)
    end
end
