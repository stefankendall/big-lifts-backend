class CorsController < ApplicationController
  def preflight
    cors_set_access_control_headers
    render nothing: true, :content_type => 'text/plain'
  end
end
