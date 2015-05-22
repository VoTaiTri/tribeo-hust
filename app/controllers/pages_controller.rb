class PagesController < ApplicationController
  def home 
    if user_signed_in? && current_user.is_admin?
      @rejected = Course.rejected_by.all
    elsif user_signed_in?
      @asigned = Course.assigned_to(current_user.id).all
      @accepted = Course.accepted_by(current_user.id).all
    end        
  end
end
