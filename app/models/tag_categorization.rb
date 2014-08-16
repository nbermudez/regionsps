class TagCategorization < ActiveRecord::Base
  attr_accessible :id, :category_id, :tag_id, :tag_position

  def tags
  	tm = TagCategorization.where(:category_id => self.category_id)
  	ids = []
  	tm.each do |t|
  		ids.push(t.tag_id)
  	end

  	return Tag.where("id in (?)", ids)
  end
end
