class CreateHqCages < ActiveRecord::Migration
  def self.up
    create_table :hq_cages do |t|
      t.integer :hq_site_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :hq_cages
  end
end
