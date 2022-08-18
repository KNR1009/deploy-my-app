class TasksController < ApplicationController
  before_action :set_task, only: [:update, :destroy, :show]

  def index
    tasks = Task.all
    render json: tasks
  end

  def create
    task = Task.new(task_params)
    if task.save
      head :no_content
    else 
      errors = @task.errors.full_messages.map { |message| { message: message } }
      render json: errors, status: :bad_request
    end
  end

  def destroy
    @task.destroy
    head :ok
  end

  def show
    render json:@task
  end


  def update
    if @task.update(task_params)
      head :no_content
    else
      errors = @task.errors.full_messages.map { |message| { message: message } }
      render json: errors, status: :bad_request
    end
  end

  private

  def task_params
      params.permit(
        :name,
        :is_done
      )  
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
