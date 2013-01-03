class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :name
      t.float :weight
      t.integer :sets
      t.integer :reps
      t.string :notes
      t.timestamp :date

      t.references :specific_workout, :polymorphic => true
      t.references :workout

      t.timestamps
    end
  end
end
