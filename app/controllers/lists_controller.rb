class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  # GET /lists
  def index
    @user = current_user
    if params[:view]=='all'
      @lists = List.all_available(@user) 
    else
      @lists = @user.lists
    end
  end

  # GET /lists/1
  def show
    cred_check
    @items = @list.items.completed
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
    cred_check
  end

  # POST /lists
  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id

    if @list.save
      redirect_to list_path(@list), notice: 'List was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /lists/1
  def update
    if @list.update(list_params)
      redirect_to list_path, notice: 'List was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /lists/1
  def destroy
     @list.destroy
    redirect_to lists_path
  end

  private

    def cred_check
      redirect_to lists_path(current_user), alert: "Unauthorized action" unless current_user.lists.include?(@list)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:title, :permissions)
    end
end
