class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :destroy, Food, user_id: user.id
    can :destroy, Recipe, user_id: user.id
    can :manage, Inventory, user:
  end
end
