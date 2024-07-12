class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :local
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
