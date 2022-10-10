class RecipesController < ApplicationController
    before_action :authorize
    rescue_from ActiveRecord::RecordInvalid , with: :response_unprocessable_entity

    def index
        recipes = Recipe.all
        render json: recipes
    end

    def create
        user_id = session[:user_id]
        user = User.find_by(id: user_id)
        recipe = user.recipes.create!(recipe_params)
        render json: recipe, status: :created
        
    end

    private
    def authorize
        # @abc = User.find_by(id: session[:user_id])
        return render json: {errors: ["Not authorized"]}, status: :unauthorized unless session[:user_id]
        # unless @abc
    end

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete, :user_id)
    end

    def response_unprocessable_entity(invalid)
       render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
