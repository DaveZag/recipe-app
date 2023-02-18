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
    @user = current_user
    @recipe = @user.recipes.find(params[:id])
    @foods = RecipeFood.where(recipe_id: @recipe.id)
    @recipe_foods = @recipe.recipe_foods
    @inventories = Inventory.where(user: current_user)

    @inventory_data = Inventory.all
    return if params[:inventory_id].nil?

    # rubocop:disable Layout/LineLength
    @foods = RecipeFood.joins(:food).select('foods.id as food_id, name as food_name, quantity, price, quantity * price as value, recipe_id').where(recipe_id: params[:id])
    # rubocop:enable Layout/LineLength
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
