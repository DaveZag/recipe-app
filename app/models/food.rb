class Food < ApplicationRecord
  has_many :inventory_foods, dependent: :destroy
  has_many :recipe_foods, dependent: :destroy
  has_many :recipes, through: :recipe_foods, dependent: :destroy

  validates :name, :measurement_unit, :price, presence: true
  validates :price, numericality: true, comparison: { greater_than: 0 }
end
