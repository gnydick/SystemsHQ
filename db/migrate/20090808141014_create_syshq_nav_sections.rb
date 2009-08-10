class CreateSyshqNavSections < ActiveRecord::Migration
  def self.up
    create_table :syshq_nav_sections do |t|
      t.boolean :view
      t.integer :position
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :syshq_nav_sections
  end
end
