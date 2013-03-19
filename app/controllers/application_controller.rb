class ApplicationController < ActionController::Base
  after_filter :cors_set_access_control_headers, :except => :preflight

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, PUT, DELETE'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, Cache-Control, Pragma, Content-Type, Authorization, AppVersion'
    headers['Access-Control-Max-Age'] = '1728000'
  end

  def authenticate_user
    authenticate_or_request_with_http_basic do |username, password|
      @user = User.find_by_username(username)
      @user and @user.authenticate(password)
    end
  end
end
