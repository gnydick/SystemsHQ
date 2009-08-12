class AddDescriptionHqApps < ActiveRecord::Migration
  def self.up
    add_column :hq_apps, :description, :text
  end

  def self.down
    remove_column :hq_apps, :description
  end
end
