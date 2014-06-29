class TimeZoneSerializer < ActiveModel::Serializer
  attributes :id, :name, :city, :gmt
end
