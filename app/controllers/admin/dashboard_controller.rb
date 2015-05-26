class Admin::DashboardController < Admin::BaseController
  def home
    @term = Term.first.current
    @rejected = Course.rejected_by.all
    @need_assign = Course.need_assign.all
    @timeout = Course.outtime_assign @term
  end
end
