class HqConnectedNic < ActiveRecord::Base
  belongs_to :hq_nic
  belongs_to :hq_netconnection
end
