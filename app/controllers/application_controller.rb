class ApplicationController < ActionController::Base
    include SessionsHelper

    
    private

        # Confirms a logged-in user.
        def logged_in_user
            unless logged_in?
                flash[:danger] = "Please log in."
                redirect_to login_url, status: :see_other
            end
        end

        # Confirms an admin user.
        def admin_user
            unless current_user.admin?
                flash[:error] = "You do not have the authorization to proceed"
                redirect_to root_url, status: :see_other
            end
        end
end
