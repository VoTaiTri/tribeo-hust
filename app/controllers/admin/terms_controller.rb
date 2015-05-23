class Admin::TermsController < Admin::BaseController
  respond_to :html, :js

  def update
    @term = Term.first
    @term.update_attributes term_params
  end

  private
  def term_params
    params.require(:term).permit :current
  end
end
