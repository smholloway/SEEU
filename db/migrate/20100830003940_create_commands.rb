class CreateCommands < ActiveRecord::Migration
  def self.up
    create_table :commands do |t|
      t.string :data
      t.integer :actuator_id

      t.timestamps
    end
  end

  def self.down
    drop_table :commands
  end
end
