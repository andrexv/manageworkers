class Workers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
        @worker = Worker.find_for_facebook_oauth(request.env["omniauth.auth"], current_worker)
        if @worker
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
          sign_in_and_redirect @worker, :event => :authentication
        else
          session["devise.facebook_data"] = request.env["omniauth.auth"]
          flash[:error] = "You are not currently registered on the page. Please contact the site administrator."
          redirect_to workers_path
        end
      end
end