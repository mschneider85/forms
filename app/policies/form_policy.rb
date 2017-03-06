class FormPolicy < ApplicationPolicy
  def index?
    !user.anonymous?
  end
end
