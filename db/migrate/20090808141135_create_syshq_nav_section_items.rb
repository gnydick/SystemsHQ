class CreateSyshqNavSectionItems < ActiveRecord::Migration
  def self.up
    create_table :syshq_nav_section_items do |t|
      t.integer :syshq_nav_section_id
      t.boolean :view
      t.integer :position
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :syshq_nav_section_items
  end
end
