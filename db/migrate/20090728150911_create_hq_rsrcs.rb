class CreateHqRsrcs < ActiveRecord::Migration
  def self.up
    create_table :hq_rsrcs do |t|
      t.string :name
      t.string :path
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :hq_rsrcs
  end
end
