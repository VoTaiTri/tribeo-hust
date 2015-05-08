class Admin::SubjectsController < Admin::BaseController
  helper_method :sort_column, :sort_direction
  respond_to :html, :js
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  def index
    @subjects = Subject.search_by(params[:search]).order(sort_column + ' ' + sort_direction)
    @subjects= @subjects.paginate page: params[:page], per_page: 10
    authorize! :read, @subjects
  end

  def new
    @subject = Subject.new
    authorize! :new, @subject
  end

  def create
    @subject = Subject.new subject_params
    authorize! :create, @subject
    if @subject.save
      flash[:success] = "Thêm môn học mới thành công."
      redirect_to admin_subjects_path
    else
      render :new
    end
  end

  def show
    authorize! :read, @subject
  end

  def edit
    authorize! :edit, @subject
  end

  def update
    authorize! :update, @subject
    if @subject.update_attributes subject_params
      flash[:success] = "Thông tin môn học đã được cập nhật."
      redirect_to admin_subjects_path
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @subject
    @subject.destroy
  end

  private
  def subject_params
    params.require(:subject).permit :name
  end

  def set_subject
    @subject = Subject.find params[:id]
  end

  def sort_column
    Subject.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
