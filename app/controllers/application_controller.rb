class ApplicationController < ActionController::Base
  protect_from_forgery

  after_filter :cors_set_access_control_headers

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, DELETE, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end
end
