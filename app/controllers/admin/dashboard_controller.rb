class Admin::DashboardController < Admin::BaseController
  def home
    @rejected = Course.rejected_by.all
    @need_assign = Course.need_assign.all
  end
end
