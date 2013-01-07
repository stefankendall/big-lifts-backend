class LogController < ApplicationController
  before_filter :authenticate_user

  def authenticate_user
    authenticate_or_request_with_http_basic do |username, password|
      @user = User.find_by_username(username)
      @user and @user.authenticate(password)
    end
  end

  def create
    workout = Workout.new(:local_workout_id => params[:workout_id])
    params[:logs].each { |l| workout.logs.build l } if params[:logs]
    @user.workouts() << workout

    if @user.save
      render :json => {}, :status => :ok
    else
      render :json => {:status => :error, :errors => workout.errors}, :status => :bad_request
    end
  end

  def update
    workout = @user.workouts().find { |w| w.local_workout_id == params[:id] }
    workout.logs.delete_all()
    params[:logs].each { |l| workout.logs.build l } if params[:logs]

    if workout.save
      render :json => {}, :status => :ok
    else
      render :json => {:status => :error, :errors => workout.errors}, :status => :bad_request
    end
  end

  def index
    render :json => @user.workouts.to_json(:include => :logs)
  end
end
