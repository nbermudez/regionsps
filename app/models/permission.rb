class Permission < ActiveRecord::Base
  attr_accessible :description, :name

  has_and_belongs_to_many :roles

  after_create  :add_new_permission_to_admins

  private
    def add_new_permission_to_admins

      roles = Role.where(:name => "Administrador")

      roles.each do |r|
        r.permissions  << self
      end

    end
end
