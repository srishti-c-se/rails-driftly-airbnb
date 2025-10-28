class CreateAvailabilities < ActiveRecord::Migration[7.1]
  def change
    create_table :availabilities do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.string :note

      t.timestamps
    end
  end
end
