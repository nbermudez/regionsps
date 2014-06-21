class Stake < ActiveRecord::Base
  attr_accessible :id, :name
  has_many :chapels
end
