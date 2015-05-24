class CoursesController < ApplicationController
  respond_to :js, :html

  def index
    if params[:user_id]
      if params[:type] == "new_assigned"
        @title = "Danh sách các lớp học mới được phân công"
        @courses = Course.assigned_to params[:user_id]
      elsif params[:type] == "accepted"
        @title = "Danh sách các lớp học đã xác nhận"
        @courses = Course.accepted_by params[:user_id]
      else
        @title = "Danh sách các lớp học liên quan"
        @courses = Course.teach_by params[:user_id]
      end
    end
  end

  def show
    @course = Course.find params[:id]
    if @course.subject.species == "normal"
      @timetables = @course.timetables
    end
  end

  def update
    @course = Course.find params[:id]
    if params[:user_confirm] == "rejected"
      user_rejected = @course.user_rejected.to_s + current_user.id.to_s + ","
      @course.update_attributes user_rejected: user_rejected, user_confirm: params[:user_confirm]
    elsif params[:user_confirm] == "accepted"
      @course.update_attributes user_confirm: params[:user_confirm], division_state: "done"
    end
  end

  private
  def course_params
    params.require(:course).permit :user_rejected, :user_confirm
  end
end
