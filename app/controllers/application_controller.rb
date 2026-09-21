class ApplicationController < ActionController::Base
  before_action :set_current_user

  attr_reader :current_user
  helper_method :current_user

  def after_sign_in_path_for(resource)
    if resource.admin? || resource.house_operator?
      admin_root_path
    else
      dashboard_path
    end
  end

  private

  def set_current_user
    @current_user = begin
      warden.user(:user)
    rescue => e
      Rails.logger.error("AUTH ERROR: #{e.message} \n #{e.backtrace.join("\n")}")
      nil
    end
    
    # Assign to Current.user for thread-safe global access across models/namespaces
    Current.user = @current_user
  end

  def require_authentication
    unless current_user
      redirect_to new_session_path, alert: "You must log in first."
    end
  end
end
