class CreateActuators < ActiveRecord::Migration
  def self.up
    create_table :actuators do |t|
      t.string :name
      t.text :description
      t.string :manufacturer
      t.string :model
      t.string :data_uri
      t.string :configuration_uri

      t.timestamps
    end
  end

  def self.down
    drop_table :actuators
  end
end
