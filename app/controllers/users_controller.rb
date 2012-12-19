class UsersController < ApplicationController
  def create
    user = User.create(params[:user])
    if user.save
      response.status = 201
      render :json => user
    else
      response.status = 400
      render :json => {:status => :error}
    end
  end
end
