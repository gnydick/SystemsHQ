class CreatePptNodes < ActiveRecord::Migration
  def self.up
    create_table :ppt_nodes do |t|
      t.integer :ppt_class_id
      t.integer :puppetized_node_id
      t.string :puppetized_node_type

      t.timestamps
    end
  end

  def self.down
    drop_table :ppt_nodes
  end
end
