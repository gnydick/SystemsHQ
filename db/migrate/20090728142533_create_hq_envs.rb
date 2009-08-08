class CreateHqEnvs < ActiveRecord::Migration
  def self.up
    create_table :hq_envs do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :hq_envs
  end
end
