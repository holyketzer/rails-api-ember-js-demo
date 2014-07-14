class Timezone < ActiveRecord::Base
  validates :name, :city, :gmt, :user, presence: true
  validates :name, uniqueness: { case_sensitive: false, scope: :user_id }

  belongs_to :user
end