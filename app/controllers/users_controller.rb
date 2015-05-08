class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  respond_to :html, :js

  def index
    @users = User.search_by(params[:search]).order(sort_column + ' ' + sort_direction)
    @users= @users.paginate page: params[:page], per_page: 10
    authorize! :read, @users
  end

  def show
    @user = User.find params[:id]
    @subjects = @user.technicals.paginate page: params[:page], per_page: 5
    authorize! :read, @users
  end

  def edit
    @user = User.find params[:id]
    authorize! :edit, @user
  end

  def update
    @user = User.find params[:id]
    authorize! :update, @user
    if @user.update_attributes user_params
      flash[:success] = "Danh sách môn học giảng viên đẳm nhiệm đã được cập nhật."
      redirect_to root_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit technical_ids: []
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
