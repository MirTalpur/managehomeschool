class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  after_create :create_teacher_or_student, on: :create
  after_update :update_teacher_or_student, on: :update

  private
  def create_teacher_or_student
    # teacher = Teacher.create(:email => self.email, :password => self.password, :user_id => self.id)
    #[#<User id: 2, email: "test1@gmail.com", 
    # created_at: "2019-02-01 06:21:37", updated_at: "2019-02-01 06:21:37", user_type: "teacher">, #<User id: 3, email: "test2@gmail.com", created_at: "2019-02-01 06:25:08", updated_at: "2019-02-01 06:25:08", user_type: "teacher">]>
    # check what self.type is set to and accodingly create a student or teacher with that
    if self.user_type.eql? "teacher"
      teacher = Teacher.create(:email => self.email, :password => self.password, :created_at => self.created_at,
                               :updated_at => self.updated_at, :user_id => self.id)
      teacher.save
    else
      student = Student.create(:email => self.email, :password => self.password, :created_at => self.created_at,
                               :updated_at => self.updated_at, :user_id => self.id)
      student.save
    end
  end

  def update_teacher_or_student
    if self.user_type.eql? "teacher"
      teacher = Teacher.where(:id => self.id).update_all(:email => self.email, :password => self.password, :created_at => self.created_at,
                                                         :updated_at => self.updated_at, :user_id => self.id)
      teacher.save
    else
      student = Student.where(:id => self.id).update_all(:email => self.email, :password => self.password, :created_at => self.created_at,
                                                         :updated_at => self.updated_at, :user_id => self.id)
      student.save
    end
  end
end
