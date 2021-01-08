class Location
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: "location"

  field :city, type: String
  field :lat, type: String
  field :lng, type: String
  field :country, type: String
  field :iso2, type: String
  field :admin_name, type: String

  has_one :user, dependent: :destroy

end
