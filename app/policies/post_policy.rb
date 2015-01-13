class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def edit?
    user.present? && (record.user == user || user.admin?)
  end

  def destroy?
    edit?
  end
end
