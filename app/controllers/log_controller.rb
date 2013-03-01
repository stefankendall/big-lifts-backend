class LogController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def create
    name = params[:name] || '5/3/1'
    workout = Workout.new(:workout_id => params[:workout_id], :name => name)

    if params[:logs]
      params[:logs].each { |l| add_log_to_workout workout, l }
    end

    begin
      User.transaction do
        @user.delete_workout_by_id workout.workout_id

        @user.workouts() << workout
        @user.save!
        render :json => {}, :status => :ok
      end
    rescue
      render :json => {:status => :error, :errors => @user.errors}, :status => :bad_request
    end
  end

  def add_log_to_workout(workout, log_data)
    specific = log_data.delete :specific

    log_data['date'] = Time.at(log_data['date'].to_i)
    log = workout.logs.build log_data

    if specific
      log.specific_workout =
          case specific[:type]
            when '5/3/1'
              W531.new(specific[:data])
          end
    end
  end

  def index
    render :json => @user.workouts.to_json()
  end

  def destroy
    @user.workouts.destroy_all
    render :json => {}, :status => :ok
  end
end
