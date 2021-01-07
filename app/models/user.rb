require 'bcrypt'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include BCrypt

  before_save :encrypt_password

  validates :email, presence: true, uniqueness: true
  validates :fullname, :birthday, :city, presence: true
  validates :password, presence: true, length: { minimum: 8, maximum: 16 }

  field :email, type: String
  field :password, type: String
  field :fullname, type: String
  field :birthday, type: Date
  field :city, type: String

  def encrypt_password
    self.password = BCrypt::Password.create(password) 
  end

end
