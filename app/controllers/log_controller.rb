class LogController < ApplicationController
  def create
    workout = Workout.new(:local_workout_id => params[:workout_id])
    params[:logs].each { |l| workout.logs.build l } if params[:logs]

    if workout.save
      render :json => {}, :status => :ok
    else
      render :json => {:status => :error, :errors => workout.errors}, :status => :bad_request
    end
  end

  def index
    username = params[:username]
    workouts = User.find_by_username(username).workouts
    render :json => workouts.to_json(:include => :logs)
  end
end
