class GeneralShoppingListController < ApplicationController
    before_action :authenticate_user!
    def index
      @food_items = Food.all
    end
  end