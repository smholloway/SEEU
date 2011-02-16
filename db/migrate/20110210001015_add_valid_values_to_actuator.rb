class AddValidValuesToActuator < ActiveRecord::Migration
  def self.up
    add_column :actuators, :valid_values, :string
  end

  def self.down
    remove_column :actuators, :valid_values
  end
end
