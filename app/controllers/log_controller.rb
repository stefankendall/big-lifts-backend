class LogController < ApplicationController
  def create
    workout = Workout.new(:local_workout_id => params[:local_workout_id])
    params[:logs].each { |l| workout.logs.build l } if params[:logs]

    if workout.save
      render :json => {}, :status => :ok
    else
      render :json => {:status => :error, :errors => workout.errors}, :status => :bad_request
    end
  end
end
