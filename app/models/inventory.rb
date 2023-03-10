class Inventory < ApplicationRecord
  has_many :inventory_foods, foreign_key: :inventory_id
  has_many :foods, through: :inventory_foods
  belongs_to :user, foreign_key: :user_id

  validates :name, presence: true, length: { maximum: 50 }
end
