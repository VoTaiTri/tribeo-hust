class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.is_admin?
      can :read, :all
      can :manage, Subject
      can [:new, :create, :destroy], User
    elsif user.is_lecturer?
      can :read, :all
      can [:index, :show], User
      can [:edit,:update], User, id: user.id
      can [:index, :show], Subject
    end 
  end
end
