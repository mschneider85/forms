# class Ability
#   include CanCan::Ability
#
#   def initialize(user)
#     return if user.anonymous?
#
#     can :manage, Form
#
#     if user.admin?
#       can :manage, User
#     else
#       can :manage, User, id: user.id
#     end
#   end
# end
