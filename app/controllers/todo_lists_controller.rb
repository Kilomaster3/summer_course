class TodoListsController < ApplicationController
  before_action :todo_list, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @user = current_user
    @todo_lists = TodoList.where(user_id: current_user)
  end

  def show
    @todo_list = TodoList.find(params[:id])
  end

  def new
    @todo_list = TodoList.new
  end

  def edit; end

  def create
    @user = User.find(params[:user_id])
    @todo_list = TodoList.new(todo_list_params)
    @todo_list[:user_id] = @user.id
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

  def current_user
    @user = current_user
  end

  def todo_list
    @user = User.find(params[:user_id])
    @todo_list = TodoList.find(params[:id])
  end

  def todo_list_params
    params.require(:todo_list).permit(:title, :description)
  end
end
