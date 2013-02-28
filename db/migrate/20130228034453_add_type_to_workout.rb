class AddTypeToWorkout < ActiveRecord::Migration
  def change
    add_column :workouts, :type, :string, :default => '5/3/1'
  end
end
