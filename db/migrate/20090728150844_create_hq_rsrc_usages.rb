class CreateHqRsrcUsages < ActiveRecord::Migration
  def self.up
    create_table :hq_rsrc_usages do |t|
      t.integer :hq_proc_id
      t.integer :hq_rsrc_id

      t.timestamps
    end
  end

  def self.down
    drop_table :hq_rsrc_usages
  end
end
