class CreateHqSites < ActiveRecord::Migration
  def self.up
    create_table :hq_sites do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :hq_sites
  end
end
