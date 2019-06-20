class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.time :time
      t.timestamps
      t.string :course_name
      t.integer :schedule_id
      t.integer :grade_percentage
      t.string :letter_grade
    end
  end
end
