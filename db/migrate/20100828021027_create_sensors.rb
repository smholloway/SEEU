class CreateSensors < ActiveRecord::Migration
  def self.up
    create_table :sensors do |t|
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
    drop_table :sensors
  end
end
