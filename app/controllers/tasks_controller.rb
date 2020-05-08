class TasksController < ApplicationController
 before_action :require_user_logged_in
 before_action :correct_user, only:[:show, :edit, :destroy, :update]
 
  def index
    @tasks = current_user.tasks
  end

  def show
  end

  def new
  @task = Task.new
  end

  def create
  @task = Task.new(task_params)
  @task.user_id = current_user.id
    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @task
    else
     flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  

  
 private
  def correct_user
      @task = Task.find(params[:id])
    unless @task.user == current_user
      redirect_to root_url
    end
  end

 

 def task_params
  params.require(:task).permit(:content, :status)
 end


 
end  


