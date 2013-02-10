class AddUnitsToLog < ActiveRecord::Migration
  def change
    add_column :logs, :units, :string
  end
end
