class HqTasksAddPosition < ActiveRecord::Migration
  def self.up
    add_column :hq_tasks, :position, :integer
  end

  def self.down
  end
end
