class UsersController < ApplicationController
  def create
    user = User.create(:username => params[:username], :password => params[:password])
    if user.save
      render :json => user, :status => :created
    else
      logger.error user.errors
      render :json => {:status => :error, :errors => user.errors}, :status => :bad_request
    end
  end
end
