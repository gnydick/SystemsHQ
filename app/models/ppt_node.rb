class PptNode < ActiveRecord::Base

  
  belongs_to :puppetized_node, :polymorphic => :true
  belongs_to :ppt_class
  
  @@screen_name = 'Puppet Node'
  
  def screen_name
    return @@screen_name
  end
  
  def self.screen_name
    return @@screen_name
  end
  
  def self.excluded_from_reflected
    return [:ppt_nodes]
  end

  
end
