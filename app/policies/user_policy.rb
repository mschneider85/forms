class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def update?
    user.admin? || record == user
  end

  def permitted_attributes
    if user.admin? && record != user
      [:username, :role]
    else
      [:username]
    end
  end
end
