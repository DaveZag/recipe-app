class FoodsController < ApplicationController
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

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity).merge(user: current_user)
  end
end