class CreateHqSystems < ActiveRecord::Migration
  def self.up
    create_table :hq_systems do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :hq_systems
  end
end
