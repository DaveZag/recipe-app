class RecipeFoodController < ApplicationController
  before_action :set_recipe_foods, only: %i[edit update destroy]
  before_action :set_recipe, only: %i[show edit new create destroy]
  before_action :set_food, only: %i[create update]
  before_action :set_user, only: %i[index show new edit create]

  def new
    @recipe_foods = RecipeFood.new
  end

  def edit
    @recipe_foods
  end

  def create
    @recipe_foods = RecipeFood.new(recipe: @recipe, food: @food, quantity: recipe_foods_params[:quantity])

    if @recipe_foods.save
      flash[:success] = 'Recipe food was successfully created.'
      redirect_to user_recipe_url(@user, @recipe)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @recipe_foods.update(food: @food, quantity: recipe_foods_params[:quantity])
      flash[:success] = 'Recipe food was successfully updated.'
      redirect_to user_recipe_url(@user, @recipe)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @recipe_foods.destroy
      flash[:success] = 'Recipe food was successfully removed.'
    else
      flash.now[:error] = 'Error: Recipe food could not be removed'
    end
    redirect_to user_recipe_url(@user, @recipe)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_recipe
    @recipe = set_user.recipes.find(params[:recipe_id])
  end

  def set_recipe_foods
    @recipe_food = set_recipe.recipe_foods.find(params[:id])
  end

  def set_food
    @food = set_user.foods.find(recipe_foods_params[:food_id])
  end

  def recipe_foods_params
    params.require(:recipe_foods).permit(:food_id, :quantity)
  end
end
