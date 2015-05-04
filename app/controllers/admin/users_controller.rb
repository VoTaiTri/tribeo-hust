class Admin::UsersController < Admin::BaseController
  helper_method :sort_column, :sort_direction
  respond_to :html, :js

  def index
    @users = User.search_by(params[:search]).order(sort_column + ' ' + sort_direction)
    @users= @users.paginate page: params[:page], per_page: 10
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "Thêm thông tin giảng viên mới thành công."
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def show
    @user = User.find params[:id]
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
  end

  private
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def user_params
    params.require(:user).permit :email, :name, :password, :password_confirmation
  end
end