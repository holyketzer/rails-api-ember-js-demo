class AddUserToTimezone < ActiveRecord::Migration
  def change
    add_reference :timezones, :user, index: true
  end
end
