class Resource < ActiveRecord::Base
  belongs_to :article
	attr_accessible :filename, :position, :content_type, :file, :tags_attributes, :thumbnail, :description, :url

	mount_uploader :file, FileUploader
	mount_uploader :thumbnail, ImageUploader

	after_save :fill_position
	validates :filename, :presence => true
	validates :description, :presence => true
	validates :thumbnail, :presence => true

	def tags
		tmp = Array.new
		tags = Tagging.where(:resource_id => self.id)
		tags.each do |t|
			tmp.push(t.tag_id)
		end
		return Tag.where('id in (?)', tmp)
	end

	private
		def fill_position
			if (self.position.nil?)
				self.position = self.id
				self.save
			end
		end
end