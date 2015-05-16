class CreateTimetables < ActiveRecord::Migration
  def change
    create_table :timetables do |t|
      t.string :day
      t.string :start_time
      t.string :finish_time
      t.string :room
      t.references :course, index: true

      t.timestamps null: false
    end
    add_foreign_key :timetables, :courses
  end
end
