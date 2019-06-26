class CreateHomeworks < ActiveRecord::Migration[5.2]
  def change
    create_table :homeworks do |t|
      t.string :title
      t.text :description
      t.date :due_date
      t.boolean :graded
      t.integer :grade_percentage
      t.string :letter_grade
      t.integer :student_id
      t.integer :course_id
      t.string :file
      t.timestamps
    end
  end
end
