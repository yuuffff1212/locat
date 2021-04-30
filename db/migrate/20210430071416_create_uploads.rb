class CreateUploads < ActiveRecord::Migration[6.1]
  def change
    create_table :uploads do |t|
      t.string :title, null: false
      t.text :text, null: false
      t.text :url
      t.text :working_day
      t.text :day_off
      t.integer :cafe_wifi_id, null: false
      t.integer :cafe_charging_id, null: false
      t.integer :cafe_smoking_id, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end