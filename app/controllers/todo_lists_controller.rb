class TodoListsController < ApplicationController
  before_action :todo_list, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @todo_lists = TodoList.where(users_id: current_user.id)
  end

  def show; end

  def new
    @todo_list = TodoList.new
  end

  def edit; end

  def create
    @todo_list = TodoList.new(todo_list_params)
    @todo_list.users_id = current_user.id

    respond_to do |format|
      if @todo_list.save
        format.html { redirect_to @todo_list, notice: 'Todo list was successfully created.' }
        format.json { render :show, status: :created, location: @todo_list }
      else
        format.html { render :new }
        format.json { render json: @todo_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @todo_list.update(todo_list_params)
        format.html { redirect_to @todo_list, notice: 'Todo list was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo_list }
      else
        format.html { render :edit }
        format.json { render json: @todo_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @todo_list.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Todo list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def todo_list
    @todo_list = TodoList.find(params[:id])
    redirect_to root_path if @todo_list.nil?
  end

  def todo_list_params
    params.require(:todo_list).permit(:title, :description)
  end
end
