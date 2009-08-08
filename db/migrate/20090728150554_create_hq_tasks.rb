class CreateHqTasks < ActiveRecord::Migration
  def self.up
    create_table :hq_tasks do |t|
      t.integer :hq_app_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :hq_tasks
  end
end
