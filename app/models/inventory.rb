class Inventory < ApplicationRecord
    belongs_to :inventory
    belongs_to :food, foreign_key: 'food_id'
end
