class CreateHqSlices < ActiveRecord::Migration
  def self.up
    create_table :hq_slices do |t|
      t.integer :hq_san_id
      t.integer :hq_vserver_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :hq_slices
  end
end
