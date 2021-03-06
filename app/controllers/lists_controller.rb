class ListsController < ApplicationController
  def index
    @lists = List.all
    @movies = Movie.all
    authorize @list
  end

  def show
    @bookmark = Bookmark.new
    @list = List.find(params[:id])
    authorize @list
  end

  def new
    @list = List.new
    authorize @list
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new
    end
    authorize @list
  end

  def destroy
    set_list
    @list.destroy
    redirect_to lists_path
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :id)
  end
end
