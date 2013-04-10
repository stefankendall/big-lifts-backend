class AddWorkoutIdIndexToLogs < ActiveRecord::Migration
  def change
    add_index :logs, :workout_id
  end
end
