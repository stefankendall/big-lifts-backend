class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :name
      t.float :weight
      t.integer :sets
      t.integer :reps
      t.integer :expected_reps
      t.integer :cycle
      t.integer :week
      t.string :notes
      t.timestamp :date

      t.timestamps

      t.references :user
    end
  end
end
