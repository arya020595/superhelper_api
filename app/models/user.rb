class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :email, type: String
  field :passowrd, type: String
  field :fullname, type: String
  field :birthday, type: Date
  field :city, type: String
end
