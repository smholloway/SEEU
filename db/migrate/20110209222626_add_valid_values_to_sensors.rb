class AddValidValuesToSensors < ActiveRecord::Migration
  def self.up
    add_column :sensors, :valid_values, :string
  end

  def self.down
    remove_column :sensors, :valid_values
  end
end
