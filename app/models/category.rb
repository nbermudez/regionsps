class Category < ActiveRecord::Base
  attr_accessible :name, :position

  validates :name, :presence => true, :uniqueness => true
  after_save :fill_position

  private
    def fill_position
      if (self.position.nil?)
        self.position = self.id
        self.save
      end
    end
end
