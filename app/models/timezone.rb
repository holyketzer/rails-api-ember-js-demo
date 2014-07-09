class Timezone < ActiveRecord::Base
  validates :name, :city, :gmt, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  belongs_to :user
end