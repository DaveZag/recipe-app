class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!

  def new
    @recipes = Recipe.all
  end

  def create
    @recipes = Recipe.all
    @recipe_food = RecipeFood.new(recipe_food_params)

    if @recipe_food.save
      redirect_to root_path, notice: 'Recipe food was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def recipe_food_params
    params.permit(:recipe_id, :food_id, :quantity)
  end
end