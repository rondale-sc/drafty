class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_admin

  def check_admin
    if params[:admin] == 'true'
      authenticate_or_request_with_http_basic do |username, password|
        if username == "admin" && password == "ransom"
          session[:admin] = true
        end
      end
    end
  end
end
