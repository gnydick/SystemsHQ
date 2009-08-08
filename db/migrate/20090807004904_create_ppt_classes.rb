class CreatePptClasses < ActiveRecord::Migration
  def self.up
    create_table :ppt_classes do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :ppt_classes
  end
end
