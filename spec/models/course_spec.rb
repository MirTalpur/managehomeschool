require 'rails_helper'

RSpec.describe Course, type: :model do
  context "valid factory" do
    it "Course has a valid factory" do
      expect(build(:course)).to be_valid
    end
  end

  before(:each) do
    @course = FactoryBot.build(:course)
  end

  context "model fields work as attended" do
    # TODO: look into why this isn't working
    # it "time" do
    #   expect(@course.time).to be_an_instance_of(TimeWithZone)
    # end

    it "course_name" do
      expect(@course.course_name).to be_an_instance_of(String)
    end

    it "grade_percentage" do
      expect(@course.grade_percentage).to be_between(0, 100)
    end

    it "grade_letter" do
      expect(@course.letter_grade).to be_between('A', 'F')
    end
  end

  context "associations" do
    it { should belong_to :schedule }
  end
end
