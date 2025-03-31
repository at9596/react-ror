class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]
  
  # GET /tasks/completed
  def completed
    completed_tasks = Task.completed
    @pagy, @records = pagy(completed_tasks)
    render json: {
      tasks: @records
    }
  end

  # GET /tasks/search
  def search
    tasks = Task.ransack(title_cont: params[:title]).result
    render json: tasks
  end

  def show
    render json: @task
  end
  def index
    tasks = Task.all
    render json: tasks
  end

  def create
    task = Task.new(task_params)
    if task.save
      render json: task, status: :created
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    head :no_content
  end
  private
  def task_params
    params.require(:task).permit(:title, :description, :completed, :due_date)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
