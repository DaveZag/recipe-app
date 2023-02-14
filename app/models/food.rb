class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :recipes, through: :recipe_foods, dependent: :destroy

  validates :measurement_unit, :price, :quantity, presence: true
  validates :price, numericality: { greater_than: 0 }
end
