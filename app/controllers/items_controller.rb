class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
  before_filter :check_privileges!, only: [:new, :create, :edit, :save,:destroy]


  # GET /items
  # GET /items.json
  def index
    @items = Item.all

    render json: @items
  end

  # GET /items/1
  # GET /items/1.json
  def show
    render json: @item
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    if @item.save
      render json: @item, status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      head :no_content
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    head :no_content
  end

  private

  def check_privileges!
  redirect_to "/", notice: 'You dont have enough permissions to be here' unless current_admin 
end
    def set_item
      @item = Item.find(params[:id])
    end
    def item_params
      params.require(:item).permit(:name, :category, :price, :description, :image)
    end
end
