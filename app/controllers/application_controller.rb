class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :notification

    def after_sign_in_path_for(resource)
        request.env['omniauth.origin'] || root_path
    end


  def notification

    if current_user
      @invitations = InvitedToOrder.where(user_id: current_user.id).order("created_at DESC").limit(10)
    end

  end

protected

	def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up , keys: [:username , :image])
   	end

end
