class RenameLocalWorkoutId < ActiveRecord::Migration
  def change
    rename_column :workouts, :local_workout_id, :workout_id
  end
end
