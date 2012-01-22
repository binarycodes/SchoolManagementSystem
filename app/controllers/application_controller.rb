class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :admin?

  protected
  
  def authorize
    unless admin?
      flash[:alert] = "Unauthorized access"
      redirect_to students_path
      false
    end
  end      

  def admin?
    true
  end

end
