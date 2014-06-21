class Chapel < ActiveRecord::Base
  belongs_to :stake
  attr_accessible :stake_id, :address, :name, :phone
end
