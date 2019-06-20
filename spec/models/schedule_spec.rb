require 'rails_helper'

RSpec.describe Schedule, type: :model do
  context "valid factory" do
    it "Schedule has a valid factory" do
      expect(build(:schedule)).to be_valid
    end
  end

  before(:each) do
    @schedule = FactoryBot.build(:schedule)
  end

  context "schedule model fields work as defined" do
    it "has date" do
      expect(@schedule.date).to be_an_instance_of(Date)
    end
  end
end
