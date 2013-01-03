class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.references :user

      t.string :local_workout_id

      t.timestamps
    end
  end
end
