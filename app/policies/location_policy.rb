class LocationPolicy < ApplicationPolicy
  def index?
    true
  end

  def destroy?
    user.admin?
  end

  def edit?
    user.admin?
  end

  def create?
    user.present?
  end
end
