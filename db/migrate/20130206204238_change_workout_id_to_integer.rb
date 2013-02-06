class ChangeWorkoutIdToInteger < ActiveRecord::Migration
  def up
    if Rails.env == 'production'
      connection.execute(%q{alter table workouts alter column workout_id type integer using cast(workout_id as integer)})
    else
      change_column :workouts, :workout_id, :integer
    end
  end

  def down
    change_column :workouts, :workout_id, :string
  end
end
