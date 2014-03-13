class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
    can :read, Club, Table
    can [:create, :prepare], Order
    can [:read,:update, :destroy], Order, :user_id => user.id
    can :tables_status, Club

    if user.owner_clubs?
      can :create, Club
      can [:update,:destroy], Club, :owner_id => user.id
      can [:create], Table
      can [:update, :destroy], Table, club: {owner: user}
      can [:read,:update, :destroy], Order, :table => { club: {owner: user} }
    end
  end

end
