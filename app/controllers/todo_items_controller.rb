class TodoItemsController < ApplicationController
  before_action :todo_list
  before_action :todo_item, only: [:destroy]
  before_action :todo_item, except: [:create]

  def create
    @todo_item = @todo_list.todo_items.create(todo_item_params)
    redirect_to @todo_list
  end

  def destroy
    if @todo_item.destroy
      flash[:success] = 'Todo List item was deleted.'
    else
      flash[:error] = 'Todo List item could not be deleted.'
    end

    redirect_to @todo_list
  end

  def complete
    @todo_item.update_attribute(:completed_at, Time.now)
    redirect_to @todo_list, notice: 'Todo item completed'
  end

  private

  def todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def todo_item
    @todo_item = @todo_list.todo_items.find(params[:id])
  end

  def todo_item_params
    params.require(:todo_item).permit(:content)
  end
end
