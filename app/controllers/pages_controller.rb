class PagesController < ApplicationController
    def home
      @public_recipes = Recipe.where(public: true)
    end
  end