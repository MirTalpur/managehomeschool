class ChangeStudentGradeToStudentGrade < ActiveRecord::Migration[5.2]
  def change
    rename_column :students, :grade, :student_grade
  end
end
