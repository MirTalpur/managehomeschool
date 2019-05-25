require 'rails_helper'

RSpec.describe Student, type: :model do
  context "valid factory" do
    it "user has a valid factory" do
      expect(build(:user_student)).to be_valid
    end
  end

  context "user has a grade in terms of the level they are" do
    it "assigns grade properly" do
      user_student = FactoryBot.create(:user_student)
      student = Student.where('user_id = ?', user_student.id).first
      student.update(:grade => 6)
      expect(Student.where('user_id = ?', user_student.id).first.grade).to eq(6)
    end
  end
end
