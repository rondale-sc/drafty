class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_admin
    authenticate_or_request_with_http_basic do |username, password|
      return true if username == "admin" && password == "ransom"
    end
  end
end
