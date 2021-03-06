class StudentsController < ApplicationController
  before_filter :authorize, :except => [:index, :show]

  def index
    @students = Student.search(params[:search])
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new params[:student]
    if @student.save
      redirect_to @student, :notice => "New student successfully added"
    else
      render :action => :new, :alert => "An error was encountered while saving"
    end
  end

  def show
    @student = Student.find params[:id]
    @prev_student = Student.prev(@student).first
    @next_student = Student.next(@student).first
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
