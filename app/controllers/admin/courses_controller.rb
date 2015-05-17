class Admin::CoursesController < ApplicationController
  respond_to :html, :js

  def index
    @courses = Course.all
    authorize! :read, @courses
  end

  def new
    @course = Course.new
    @button = "New"
    @timetables = @course.timetables.build
    authorize! :new, @course
  end

  def create
    @course = Course.new course_params
    authorize! :create, @course
    if @course.save
      flash[:success] = "add successfully"
      redirect_to root_url
    else
      flash.now[:danger] = "add unsuccessfully"
      render :new
    end
  end

  def edit
    @course = Course.find params[:id]

  end

  def update
    @course = Course.find params[:id]
    authorize! :update, @course
    @course.update_attributes course_params
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
