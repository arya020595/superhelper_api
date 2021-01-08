require 'bcrypt'
class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include BCrypt

  before_save :encrypt_password, :default_value_roles

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :fullname, :birthday, presence: true
  validates :password, presence: true, length: { minimum: 8, maximum: 16 }

  field :email, type: String
  field :password, type: String
  field :fullname, type: String
  field :roles, type: String
  field :birthday, type: Date

  belongs_to :location

  private 
  
  def encrypt_password
    self.password = BCrypt::Password.create(password) 
  end

  def default_value_roles
    self.roles = roles=="administrator"? "administrator" : "visitor"
  end

end
