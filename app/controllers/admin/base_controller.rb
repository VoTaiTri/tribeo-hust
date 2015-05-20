class Admin::BaseController < ActionController::Base
  before_action :authenticate_user!
  before_action :authorized_admin!

  private
  def authorized_admin!
    unless current_user.is_admin?
      flash[:alert] = "Chỉ tài khoản admin mới có quyền xem trang này."
      redirect_to root_path
    end
  end
end
