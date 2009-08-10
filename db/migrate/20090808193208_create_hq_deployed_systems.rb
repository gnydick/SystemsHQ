class CreateHqDeployedSystems < ActiveRecord::Migration
  def self.up
    create_table :hq_deployed_systems do |t|
      t.integer :hq_site_id
      t.integer :hq_env_id
      t.integer :hq_system_id

      t.timestamps
    end
  end

  def self.down
    drop_table :hq_deployed_systems
  end
end
