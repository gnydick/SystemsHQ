class CreateHqNics < ActiveRecord::Migration
  def self.up
    create_table :hq_nics do |t|
      t.integer :hq_remotenic_id
      t.integer :hq_nichaving_id
      t.string :hq_nichaving_type

      t.timestamps
    end
  end

  def self.down
    drop_table :hq_nics
  end
end
