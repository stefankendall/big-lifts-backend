class ChangeWorkoutIdToInteger < ActiveRecord::Migration
  def change
    change_column :workouts, :workout_id, :integer
  end
end
