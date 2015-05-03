class Admin::BaseController < ActionController::Base
  before_action :authenticate_user!
  before_action :authorized_admin?

  layout 'application'
  
  private
  def authorized_admin?
    unless current_user.is_admin?
      flash[:error] = "Bạn không đủ quyền hạn để xem trang này."
      redirect_to root_path
    end
  end
end