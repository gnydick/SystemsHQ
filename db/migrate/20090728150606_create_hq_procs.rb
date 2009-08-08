class CreateHqProcs < ActiveRecord::Migration
  def self.up
    create_table :hq_procs do |t|
      t.integer :hq_task_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :hq_procs
  end
end
