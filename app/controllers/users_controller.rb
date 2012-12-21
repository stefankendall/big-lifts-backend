class UsersController < ApplicationController
  filter_parameter_logging :password

  def create
    username = params[:username] || UsernameGenerator.generate
    password = params[:password] || PasswordGenerator.generate

    user = User.new({username: username, password: password})
    if user.save
      render :json => {:user => user.as_json}, :status => :created
    else
      logger.error user.errors
      render :json => {:status => :error, :errors => user.errors}, :status => :bad_request
    end
  end
end
