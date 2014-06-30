class CreateTimezones < ActiveRecord::Migration
  def change
    create_table :timezones do |t|
      t.string :name
      t.string :city
      t.integer :gmt

      t.timestamps
    end
  end
end
