class ResourcesController < ApplicationController
	def categories
		@current_page = "RECURSOS"
		@categories = Category.where('name != (?)', "GENERAL").order('position asc')
	end

	def index
		@current_page = "RECURSOS"

		@tags = Array.new
		@category = params[:id]
		tmp = TagCategorization.where('category_id = (?)', params[:id]).order(:tag_position)
    unless(tmp.nil?)
      @tags = []
      tmp.each do |i|
        @tags.push(Tag.find(i.tag_id))
      end
    end

		@path_recursos = "Recursos/#{Category.find(params[:id]).name}"
	end

	def bytag
		@current_page = "RECURSOS"
		tag = Tag.find(params[:t_id])
		@category = params[:c_id]


		@resources = tag.resources.order('position desc') unless tag.nil?
		@tag = tag.title unless tag.nil?

		@ret = "Recursos/#{Category.find(params[:c_id]).name}"
	end
end
