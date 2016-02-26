class UnlokAirController < ApplicationController
  def index
    if params[:category].eql?('helicopter')
      aircraft_category = ItemCategory.find_by(name: 'helicopter')
      @items = aircraft_category.items.all
    else
      helicopter_category = ItemCategory.find_by(name: 'aircraft')
      @items = helicopter_category.items.all
    end
  end

  def show
    @item = Item.find_by(id: params[:id])
  end
end