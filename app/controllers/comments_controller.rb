class CommentsController < ApplicationController
  before_action :comment_owner?, except: [:create]
  before_action :set_task, only: [:create]
  def index
    @comments = Comment.where(user: current_user)
    if params[:order].in? %w[new old]
      case params[:order]
      when 'new'
        @comments.order!(created_at: :desc)
      when 'old'
        @comments.order!(:created_at)
      end
    end
  end 

  def create 
    @comment = @task.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to task_path(@task)
  end
 
  private 
    
  def comment_owner?
    @profile = Profile.find(params[:profile_id])
    if !current_user
      redirect_to root_path
    elsif (current_user.profile != @profile and !@profile.share )
      redirect_to root_path
    end
  end

  def set_task 
    @task = Task.find(params[:task_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :task_id )
  end

end

