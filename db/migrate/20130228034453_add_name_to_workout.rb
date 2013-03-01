class AddNameToWorkout < ActiveRecord::Migration
  def change
    add_column :workouts, :name, :string, :default => '5/3/1'
  end
end
