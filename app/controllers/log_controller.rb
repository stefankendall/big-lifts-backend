class LogController < ApplicationController
  def create
    user = User.find_by_username(params[:username])

    if !user
      render :json => {:status => :error}, :status => :unauthorized
    else
      workout = Workout.new(:local_workout_id => params[:workout_id])
      params[:logs].each { |l| workout.logs.build l } if params[:logs]
      user.workouts() << workout

      if user.save
        render :json => {}, :status => :ok
      else
        render :json => {:status => :error, :errors => workout.errors}, :status => :bad_request
      end
    end
  end

  def update
    user = User.find_by_username(params[:username])

    if !user
      render :json => {:status => :error}, :status => :unauthorized
    else
      workout = user.workouts().find { |w| w.local_workout_id == params[:id] }
      workout.logs.delete_all()
      params[:logs].each { |l| workout.logs.build l } if params[:logs]

      if workout.save
        render :json => {}, :status => :ok
      else
        render :json => {:status => :error, :errors => workout.errors}, :status => :bad_request
      end
    end
  end

  def index
    username = params[:username]
    workouts = User.find_by_username(username).workouts
    render :json => workouts.to_json(:include => :logs)
  end
end
