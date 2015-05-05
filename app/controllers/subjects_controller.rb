class SubjectsController < ApplicationController
  helper_method :sort_column, :sort_direction
  respond_to :html, :js

  def index
    if params[:user_id]
      @user = User.find params[:user_id]
      subjects = @user.technicals.search_by params[:search]
    else
      subjects = Subject.search_by params[:search]
    end
    @subjects = subjects.order(sort_column + ' ' + sort_direction)
    @subjects = @subjects.paginate page: params[:page], per_page: 10
  end

  def show
    @subject = Subject.find params[:id]
  end

  private
  def sort_column
    Subject.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end