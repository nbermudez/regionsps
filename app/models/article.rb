class Article < ActiveRecord::Base
  has_one :resource,:foreign_key => "article_id", :dependent => :destroy
  attr_accessible :active, :published, :resource_attributes

  accepts_nested_attributes_for :resource,
                                :reject_if => :all_blank,
                                :allow_destroy => true
end
