require 'rails_helper'

RSpec.describe Homework, type: :model do
  context "valid factory" do
    it "homework has a valid factory" do
      expect(build(:homework)).to be_valid
    end
  end

  before(:each) do
    @homework = FactoryBot.build(:homework)
  end

  context "model fields work as attended" do
    it "correct title" do
      expect(@homework.title).to be_an_instance_of(String)
    end

    it "correct description" do
      expect(@homework.description).to be_an_instance_of(String)
    end

    it "has due_date" do
      expect(@homework.due_date).to be_an_instance_of(Date)
    end

    it "correct graded" do
      expect(@homework.graded).to be_in([true, false])
    end

    it "correct grade_percentage" do
      expect(@homework.grade_percentage).to be_between(0, 100)
    end

    it "correct letter_grade" do
      expect(@homework.letter_grade).to be_between('A', 'F')
    end

    it "has files as path" do
      file = "https://s3.com/path/to/file"
      file.gsub("\u0000", '')
      @homework.update(:file => file)
      expect(@homework.file).to eq(file)
    end
  end

  context "crud operations" do
    it "can delete" do
      homework_end_to_end = FactoryBot.create(:homework)
      homework = Homework.where('id = ?', homework_end_to_end.id).first
      homework.destroy!
      expect(Homework.where('id = ?', homework.id).first).to be_nil
    end
  end

  context "associations" do
    it { is_expected.to belong_to(:course).optional }
    it { should belong_to :student}
  end
end
