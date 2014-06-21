class Role < ActiveRecord::Base
  attr_accessor :name_select, :permissions_list
  attr_accessible :name, :description, :name_select, :permissions

  has_and_belongs_to_many :permissions
  has_and_belongs_to_many :users, :join_table => "users_roles"

  before_save :right_name
  after_save  :update_permissions

  private
  	def right_name
  		if self.name_select.present? and self.name_select != "Nuevo rol"
  			self.name = self.name_select
  		end
  	end

    def update_permissions
      if permissions_list.present?
        permissions.delete_all
        selected_pers = permissions_list.nil? ? []: permissions_list.collect{|id,other| Permission.find(id)}
        selected_pers.each {|per| self.permissions << per}
      end
    end
end
