class Admin::CoursesController < Admin::BaseController
  respond_to :html, :js

  def index
    @courses = Course.all
    authorize! :read, @courses
  end

  def new
    @course = Course.new
    @button = "Thêm mới"
    @timetables = @course.timetables.build
    authorize! :new, @course
  end

  def create
    @course = Course.new course_params
    authorize! :create, @course
    if @course.save
      flash[:success] = "Thêm mới thông tin mở lớp thành công."
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @course = Course.find params[:id]
    @button = "Cập nhật"
  end

  def update
    @course = Course.find params[:id]
    authorize! :update, @course
    if params[:course][:user_id]
      @course.update_attributes course_params
    else
      if @course.update_attributes course_params
        redirect_to admin_courses_path()
        flash[:success] = "Cập nhật thông tin mở lớp thành công."
      else
        render :edit
      end
    end
  end

  private
  def course_params
    params.require(:course).permit :courseID, :enroll, :max_enroll, :state,
                                  :term, :note, :timetable, :division_state,
                                  :user_rejectd, :user_confirm,
                                  :subject_id, :user_id,
                                  timetables_attributes: [:id, :day, :room,
                                                          :start_time, 
                                                          :finish_time,
                                                          :_destroy]
  end
end
