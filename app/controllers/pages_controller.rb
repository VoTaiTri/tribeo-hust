class PagesController < ApplicationController
  def home
    if user_signed_in?
      @term = Term.first.current
      @asigned = Course.assigned_to(current_user.id).all
      @accepted = Course.accepted_by current_user.id
      @accepted = @accepted.paginate page: params[:page], per_page: 5
    end        
  end
end
