class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[show edit update destroy]

  # GET /recipes or /recipes.json
  def index
    @current_user = current_user
    @recipes = @current_user.recipes
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    user = current_user
    @recipe = user.recipes.find(params[:id])
    @foods = RecipeFood.where(recipe_id: @recipe.id)
    @recipe_foods = @recipe.recipe_foods

    @inventory_data = Inventory.all
    return if params[:inventory_id].nil?

    recipe_food_list = RecipeFood.where(recipe_id: params[:id] || params[:recipe_id]).pluck(:food_id)
    @if_foods_list = InventoryFood.where(inventory_id: params[:inventory_id]).pluck(:food_id)
    @inventory = Inventory.find(params[:inventory_id])
    diff = recipe_food_list - @if_foods_list
    @meta_data = Food.where(id: diff).pluck(:id, :name, :measurement_unit, :price)
    @total_price = 0
    @meta_data.each do |item|
      @total_price += RecipeFood.find_by(food_id: item[0]).quantity * item[3]
    end
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipes_url, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        flash[:error] = 'Error: recipe could not be saved'
        redirect_to new_recipe_url
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    render :edit, status: :unprocessable_entity unless @recipe.update(public: !@recipe.public)
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :description, :preparation_time, :cooking_time, :public)
  end
end
