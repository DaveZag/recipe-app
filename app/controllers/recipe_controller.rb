class RecipeController < ApplicationController
    def index
      @recipes = current_user.recipes
    end

    def show
        @recipe = Recipe.find(params[:id])
        @recipe_foods = @recipe.recipe_foods
        @foods = current_user.foods
      end