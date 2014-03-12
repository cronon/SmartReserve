class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
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
    can [:create], Order
    can [:read,:update, :destroy], Order, :user_id => user.id 

    if user.owner_clubs?
      can :create, Club
      can [:update,:destroy], Club, :owner_id => user.id
      can [:create], Table
      #can [:update, :destroy], Table if table_belongs_user?(:id, user.id)
      can [:read,:update, :destroy], Order, :table => { club: {owner: user} }
    end
  end

  private

  def table_belongs_user?(table_id, user_id)
    Table.where(id: table_id).first.club.owner_id == user_id
  end

  def order_belongs_owner_clubs?(order_id, user_id)
    puts "OOOUUU order_id = #{order_id}, user_id = #{user_id}"
    Order.where(id: order_id).first.table.club.owner_id == user_id
  end
  #   def owner_clubs_rules
  #     can :manage, [Clubs, Orders, Tables] 
  #   end

  #   def user_rules
      
  #   end
end
