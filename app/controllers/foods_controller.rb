class FoodsController < ApplicationController
  before_action :authenticate_user!
  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)

    if @food.save
      redirect_to foods_path, notice: 'Food was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @food = Food.find(params[:id])

    if @food.destroy
      redirect_to foods_path, notice: 'Food was successfully deleted.'
    else
      render :new, notice: 'Food was not deleted.'
    end
  end

  def shopping_list
    food_list = Food.all
    recipe_foods = RecipeFood.all

    @shopping_list = []
    food_list.each do |food|
      recipe_foods.each do |recipe_food|
        next unless food.quantity < recipe_food.quantity && food.id == recipe_food.food_id

        recipe_food.quantity -= food.quantity
        @shopping_list << food
        price = food.price * food.quantity
        @total_price = @total_price.to_i + price.to_i
      end
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity).merge(user: current_user)
  end
end
