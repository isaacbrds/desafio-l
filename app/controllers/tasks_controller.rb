class TasksController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create destroy search]
  before_action :user_profile?

  before_action :find_task, only: %i[edit update show confirm_delete destroy delete_comment]
  skip_before_action :verify_authenticity_token, only: %i[search]
    
  def index
    @tasks = current_user.tasks.where(status: :complete)
    
  end

  def show 
    @comment = Comment.new
    @comments = @task.comments.order("created_at DESC")
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    @task.user = current_user
    if @task.save 
      redirect_to tasks_path, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update 
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Task was successfully destroyed.'
  end

  def complete
  end

  def incomplete
    @tasks = current_user.tasks.where(status: :incomplete)
  end

  private

  def task_params
    params.require(:task).permit(:title, :priority, :status, :privacy, :description, :share)
  end  

  def comment_params
  end 

  def find_task
    @task = Task.find(params[:id])
  end

  def sanitize_sql_like(string, escape_character = "\\")
    pattern = Regexp.union(escape_character, "%", "_")
    string.gsub(pattern) { |x| [escape_character, x].join }
  end
end

