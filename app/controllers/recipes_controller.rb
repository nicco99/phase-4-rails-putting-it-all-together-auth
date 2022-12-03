class RecipesController < ApplicationController
    before_action :authorize
    rescue_from ActiveRecord::RecordInvalid, with: :record_not_valid
 
    def index
      recipes = Recipe.all
      render json: recipes, status: :created
    end

    def create 
     recipe = Recipe.create!(recipe_params)
     render json: recipe, serializer: RecipeSerializer, status: :created     
    end


    private
  
   def record_not_valid invalid
   render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
   end

    def recipe_params
    params.permit(:title,:instructions,:minutes_to_complete)
    end 

    def authorize
   return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
    end
end
