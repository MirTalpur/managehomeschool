require 'rails_helper'

RSpec.describe Student, type: :model do
  context "valid factory" do
    it "Student has a valid factory" do
      expect(build(:student)).to be_valid
    end
  end

  context "user has a grade in terms of the level they are" do
    it "assigns grade properly" do
      student = FactoryBot.create(:student)
      user_student = Student.where('user_id = ?', student.user_id).first
      user_student.update(:student_grade => 6)
      expect(Student.where('user_id = ?', student.user_id).first.student_grade).to eq(6)
    end
  end
end
