class TimezoneSerializer < ActiveModel::Serializer
  attributes :id, :name, :city, :gmt
end
