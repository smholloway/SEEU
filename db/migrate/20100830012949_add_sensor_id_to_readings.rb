class AddSensorIdToReadings < ActiveRecord::Migration
  def self.up
    add_column :readings, :sensor_id, :integer
  end

  def self.down
    remove_column :readings, :sensor_id
  end
end
