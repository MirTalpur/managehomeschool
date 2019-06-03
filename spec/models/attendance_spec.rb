require 'rails_helper'

RSpec.describe Attendance, type: :model do
  context "valid factory" do
    it "Attendance has a valid factory" do
      expect(build(:attendance)).to be_valid
    end
  end

  before(:each) do
    @attendance = FactoryBot.build(:attendance)
  end

  context "student attendance fields work as defined" do
    it "has attending as boolean" do
      expect(@attendance.attending).to be_in([true, false])
    end

    it "shows reason as text" do
      reason = "not feeling well"
      @attendance.update(:reason => reason)
      expect(@attendance.reason).to eq(reason)
    end

    it "has files as path" do
      file = "https://s3.com/path/to/file"
      @attendance.update(:files => file)
      expect(@attendance.files).to eq(file)
    end

    it "has a valid date" do
      expect(@attendance.date).to be_an_instance_of(Date)
    end
  end
end
