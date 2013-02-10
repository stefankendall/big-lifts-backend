class LogController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user

  def authenticate_user
    authenticate_or_request_with_http_basic do |username, password|
      @user = User.find_by_username(username)
      @user and @user.authenticate(password)
    end
  end

  def create
    workout = Workout.new(:workout_id => params[:workout_id])

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
    @user.delete_workout_by_id params[:id].to_i
    render :json => {}, :status => :ok
  end
end
