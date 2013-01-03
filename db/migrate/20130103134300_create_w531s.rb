class CreateW531s < ActiveRecord::Migration
  def change
    create_table :w531s do |t|
      t.integer :cycle
      t.integer :expected_reps
      t.integer :week
      t.timestamps
    end
  end
end
