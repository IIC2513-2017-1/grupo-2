module Registered
  extend ActiveSupport::Concern

  def logged_in?
    redirect_to(root_path, notice: 'You must be logged in!') unless current_user
  end

  def permitted_user?(object)
    redirect_to(root_path, notice: 'You are not permitted to do this') unless (object.user_id == current_user.id ||
                                                                               current_user.role.name == 'admin')
  end

  def admin?
    redirect_to(root_path, notice: 'You are not permitted to do this') unless (current_user.role.name == 'admin')
  end

  def same_user?(user)
    redirect_to(root_path, notice: 'You are not permitted to do this') unless (user.id == current_user.id ||
                                                                               current_user.role.name == 'admin')
  end
end
