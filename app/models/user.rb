class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # has_one :UserType, :polymorphic => true, dependent: :destroy
  # TODO: make this more exlusive make sure the type is actually student
  after_create :create_teacher_or_student, on: :create
  after_update :update_teacher_or_student, on: :update
  before_destroy :destroy_teacher_or_student

  private
  def destroy_teacher_or_student
    if self.user_type.eql? "teacher"
      teacher = Teacher.where('user_id = ?', self.id).first
      teacher.destroy
    else
      student = Student.where('user_id = ?', self.id).first
      student.destroy
    end
  end

  def create_teacher_or_student
    # teacher = Teacher.create(:email => self.email, :password => self.password, :user_id => self.id)
    #[#<User id: 2, email: "test1@gmail.com", 
    # created_at: "2019-02-01 06:21:37", updated_at: "2019-02-01 06:21:37", user_type: "teacher">, #<User id: 3, email: "test2@gmail.com", created_at: "2019-02-01 06:25:08", updated_at: "2019-02-01 06:25:08", user_type: "teacher">]>
    # check what self.type is set to and accodingly create a student or teacher with that
    if self.user_type.eql? "teacher"
      teacher = Teacher.create(:email => self.email, :password => self.password, :created_at => self.created_at,
                               :updated_at => self.updated_at, :user_id => self.id)
      teacher.save!
    else
      student = Student.create(:email => self.email, :password => self.password, :created_at => self.created_at,
                               :updated_at => self.updated_at, :user_id => self.id)
      student.save!
    end
  end

  def update_teacher_or_student
    # determine the type of model requiring updating
    if self.user_type.eql? "teacher"
      model = Teacher
    elsif self.user_type.eql? "student"
      model = Student
    end
    # figure out the model association
    model_association = model.where('user_id = ?', self.id).first
    # check which fields need updating
    if self.previous_changes[:email] && self.previous_changes[:password]
      model_association.update(:email => self.email, :password => self.password)
      model_association.save!
    elsif self.previous_changes[:email]
      model_association.update(:email => self.email)
      model_association.save!
    elsif self.previous_changes[:password]
      model_association.update(:password => self.password)
      model_association.save!
    end
  end
end
