class InventoriesController < ApplicationController
  def index
    @inventory = Inventory.all
  end

  def show
    @inventory = Inventory.find(params[:id])
  end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)
    if @inventory.save
      redirect_to inventory_path(param[:id])
    else
      render :new
    end
  end

  def destroy
    @inventory = Inventory.find_by(id: params[:id])

    redirect_to inventories_path
    if @inventory.destroy
      flash[:success] = 'Inventory deleted'
    else
      flash.now[:error] = 'Inventory Not Deleted'
    end
  end

  def shopping
    @foods = Food.all
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name, :description).merge(user: current_user)
  end
end
