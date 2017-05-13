class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
   def index
     @tasks = Task.all.page(params[:page])
   end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.buildw(task_params)

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
    redirect_to root_url
  end

 private
 
 def set_task
   @task = Task.find(params[:id])
 end
  
 # Strong Parameter
  def task_params
    params.require(:task).permit(:status, :content)
  end
end