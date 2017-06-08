class CampaignPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.joins(:users).where(users: { id: user.id })
    end
  end

  def index?
    !user.anonymous?
  end

  def update?
    user.admin? || !campaign.published?
  end
end
