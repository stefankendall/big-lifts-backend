class UsersController < ApplicationController
  before_filter :authenticate_user, :only => [:update]

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

  def update
    username = params[:username]
    password = params[:password]

    unless username && password
      render :status => :bad_request, :json => {}
      return
    end

    if username && @user.username != username
      existing_user = User.find_by_username username
      if existing_user && BCrypt::Password.new(existing_user.password_digest) != password
        render :status => :bad_request, :json => {:status => 'user exists, bad password'}
        return
      end

      @user.username = username
    end

    @user.password = password

    if @user.save
      render :status => :ok, :json => {}
    else
      render :status => :unprocessable_entity, :json => {}
    end
  end
end
