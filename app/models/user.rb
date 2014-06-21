require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password, :password_old
  attr_accessible :email, :first_name, :last_name, :password, 
                  :password_confirmation, :encrypted_password, :password_old,
                  :phone, :chapel_id, :roles, :password_reset_code

  has_and_belongs_to_many :roles, :join_table => "users_roles"
  has_many :permissions, :through => :roles
  has_and_belongs_to_many :groups, :join_table => "users_groups"
  accepts_nested_attributes_for :roles
  accepts_nested_attributes_for :groups
  belongs_to :chapel

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, :presence => true, 
                    :uniqueness => true,
                    :format => {:with => email_regex}
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :password , :presence     => true, 
                        :confirmation => true,
                        :length       => { :within => 6..40 }
  validates :chapel_id, :presence => true

  before_save :encrypt_password

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def has_password?(submitted_password)
		self.encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
  	user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def make_password_reset_code
    self.password_reset_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    self.save(:validate => false)
  end
  
  private
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end


end
