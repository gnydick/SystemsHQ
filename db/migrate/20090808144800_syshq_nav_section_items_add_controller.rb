class SyshqNavSectionItemsAddController < ActiveRecord::Migration
  def self.up
    add_column :syshq_nav_section_items, :cntrlr, :string
  end

  def self.down
    remove_column :syshq_nav_section_items, :cntrlr
  end
end
