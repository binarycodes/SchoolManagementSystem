class StudentsController < ApplicationController
  before_filter :authorize, :except => [:index, :show]
  
  def not_found
    raise ActionController::RoutingError.new('Not Found');
  end

  def index
    @students = Student.all(:order => "created_at ASC")
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new params[:student]
    if @student.save
      redirect_to students_path, :notice => "New student successfully added"
    else
      render :action => :new, :alert => "An error was encountered while saving"
    end
  end

  def show
    @student = Student.find params[:id]
  end

  def edit
    @student = Student.find params[:id]
  end

  def update
    student = Student.find params[:id]
    student.attributes = params[:student]
    student.image_add_remove = student.updated_at if student.image_changed?
    if student.changed?
      if student.save
        redirect_to student, :notice => "Changes successfully saved"
      else
        redirect_to :back, :alert => "An error was encountered while saving the changes"
      end
    else
      redirect_to student, :alert => "No changes to save"
    end
  end

  def destroy
    redirect_to :back, :alert => "Method un-implemented"
  end

end
