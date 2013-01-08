class CorsController < ApplicationController
  def preflight
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, Cache-Control, Pragma, Content-Type'
    headers['Access-Control-Max-Age'] = '1728000'
    render nothing: true, :content_type => 'text/plain'
  end
end
