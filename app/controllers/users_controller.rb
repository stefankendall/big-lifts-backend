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

    if @user.username != username
      existing_user = User.find_by_username username

      if existing_user
        handle_existing_user password, existing_user
        return
      end
    end

    messages = []
    if @user.username != username
      messages.push "Username changed!"
    end
    if BCrypt::Password.new(@user.password_digest) != password
      messages.push "Password changed!"
    end

    @user.username = username
    @user.password = password

    if @user.save
      render :status => :ok, :json => {:status => messages.join(' ')}
    else
      render :status => :unprocessable_entity, :json => {}
    end
  end

  def handle_existing_user password, existing_user
    if BCrypt::Password.new(existing_user.password_digest) != password
      render :status => :bad_request, :json => {:status => 'User exists, bad password'}
    else
      @user.destroy
      render :status => :ok, :json => {:status => 'User recovered'}
    end
  end
end
