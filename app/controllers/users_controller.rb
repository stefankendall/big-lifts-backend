class UsersController < ApplicationController
  def create
    user = User.create(request.request_parameters)
    if user.save
      render :json => user, :status => :created
    else
      logger.error user.errors
      render :json => {:status => :error, :errors => user.errors}, :status => :bad_request
    end
  end
end
