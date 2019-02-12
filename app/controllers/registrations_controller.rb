class RegistrationsController < Devise::RegistrationsController
  def new
    super
    @teacher = Teacher.create(:email => params[:email].to_s, :password => params[:password])
  end
  
  def create
    # add custom create logic here
    super
    @teacher.save!
  end
  
  def update
    super
  end
end
