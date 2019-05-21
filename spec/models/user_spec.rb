require 'rails_helper'

RSpec.describe User, type: :model do
  context "valid factory" do
    it "user has a valid factory" do
      expect(build(:default_user)).to be_valid
      expect(build(:user_teacher)).to be_valid
      expect(build(:user_student)).to be_valid
    end
  end

  context "presence" do
    before(:all) { create(:default_user) }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    # TODO make nil not be present in property user_type
    # it { should validate_presence_of(:user_type) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should validate_length_of(:password).is_at_least(6)}
  end

  context "user_type validations" do
    it "creates a normal user with default user_type set" do
      user = FactoryBot.build(:default_user)
      expect(user.user_type).to eq('teacher') 
    end
    
    # TODO: Think about changing this to a enum of two string values (student, teacher)
    # for better type safety
    it "creates a user with different user_type set" do
      user = FactoryBot.build(:user_student)
      expect(user.user_type).to eq('student')
    end
  end

  context "correct user/teacher model is created" do
    it "user by default creates a teacher model with correct foreign key" do
      user = FactoryBot.create(:default_user)
      teacher = Teacher.where('user_id = ?', user.id).first
      expect(teacher.user_id).to eq(user.id)
    end

    it "user of type teacher creates a teacher model with correct foreign key" do
      user = FactoryBot.create(:user_teacher)
      teacher = Teacher.where('user_id = ?', user.id).first
      expect(teacher.user_id).to eq(user.id)
    end

    it "user of type student creates a student model with correct foreign key" do
      user = FactoryBot.create(:user_student)
      student = Student.where('user_id = ?', user.id).first
      expect(student.user_id).to eq(user.id)
    end
  end

  context "correct user/teacher model is destroyed" do
    it "destroys correct teacher when default_user is destroyed" do
      user = FactoryBot.create(:default_user)
      user.destroy
      teacher = Teacher.where('user_id = ?', user.id).first
      expect(teacher).to be_falsey
    end
    
    it "destroys correct teacher when user_teacher is destroyed" do
      user = FactoryBot.create(:user_teacher)
      user.destroy
      teacher = Teacher.where('user_id = ?', user.id).first
      expect(teacher).to be_falsey
    end
    
    it "destroys correct student when user_student is destroyed" do
      user = FactoryBot.create(:default_user)
      user.destroy
      student = Student.where('user_id = ?', user.id).first
      expect(student).to be_falsey
    end
  end
  
  context "correct user/teacher model is updated" do
    it "updates correct teacher when default_user email is updated" do
      user = FactoryBot.create(:default_user)
      user.update(:email => "update@gmail.com")
      teacher = Teacher.where('user_id = ?', user.id).first
      user = User.where('id = ?', user.id).first
      expect(user['email']).to eq(teacher['email'])
    end
    
    it "updates correct teacher when user_teacher email is updated" do
      user = FactoryBot.create(:user_teacher)
      user.update(:email => "update@gmail.com")
      teacher = Teacher.where('user_id = ?', user.id).first
      user = User.where('id = ?', user.id).first
      expect(user['email']).to eq(teacher['email'])
    end

    it "updates correct student when user_student email is updated" do
      user = FactoryBot.create(:user_student)
      user.update(:email => "update@gmail.com")
      student = Student.where('user_id = ?', user.id).first
      user = User.where('id = ?', user.id).first
      expect(user['email']).to eq(student['email'])
    end
  end

  context "destroying a user of teacher type gets rid of the associated students as well" do
    it "destroys students by destroying a user of teacher type" do
      user_teacher = FactoryBot.create(:user_teacher)
      user_student = FactoryBot.create(:user_student)
      teacher = Teacher.where('user_id = ?', user_teacher.id).first
      student = Student.where('user_id = ?', user_student.id).first
      student.update(:teacher_id => teacher.id)
      teacher.destroy
      student = Student.where('user_id = ?', user_student.id).first
      expect(student).to be_falsey
    end
  end

  # TODO: deleting a user of teacher type gets rid of the teacher and the students (done)
  # TODO: should destroying teacher/student destroys the user model as well? (currently no because we'd have circular
  # dependency where if user destroy teacher/student they will look to destroy User as well)
  # TODO: should a teacher CRUD operations also CRUD on the user model as well? (same as above but some of the properties
  # of teacher/student don't need to CRUD user model only just some of them)
  # TODO: currently we can have orphan's by destroying the teacher/student model and that won't
  # actually destroy the User model causing the User model to be in an orphaned stage (not destroying via teacher/student
  # model should solve this problem)
end
