class PptClassesHqEnvIdAndHqAppId < ActiveRecord::Migration
  def self.up
    add_column :ppt_classes, :hq_env_id, :integer
    add_column :ppt_classes, :hq_app_id, :integer
  end
  
  def self.down
    remove_column :ppt_classes, :hq_env_id
    remove_column :ppt_classes, :hq_app_id
  end
end
