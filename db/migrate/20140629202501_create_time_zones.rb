class CreateTimeZones < ActiveRecord::Migration
  def change
    create_table :time_zones do |t|
      t.string :name
      t.string :city
      t.integer :gmt

      t.timestamps
    end
  end
end
