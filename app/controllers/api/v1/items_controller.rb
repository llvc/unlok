class Api::V1::ItemsController < Api::V1::ApiController
  def main_category
    @main_category = ItemCategory.where("parent_category_id is null")
    render_json({:msg => "All the main categories for the items.", :success => true, :main_category => @main_category}.to_json)
  end

  def sub_category
    @main_category = ItemCategory.find_by(:id => params[:parent_category_id], :parent_category_id => nil)
    if @main_category
      @sub_category = @main_category.sub_categories
      render_json({:msg => "All the sub categories for the items.", :success => true, :main_category => @main_category, :sub_category => @sub_category}.to_json)
    else
      render_json({:msg => "All the sub categories for the items.", :success => false}.to_json)
    end
  end
  
  def all_items
    @all_items = Item.all
    render_json({:msg => "All the items.", :success => true, :items => @all_itmes}.to_json)
  end
  
  def category_items
    main_category = ItemCategory.find_by(:id => params[:parent_category_id], :parent_category_id => nil)
    if main_category
      sub_categories = main_category.sub_categories
      @items = Item.where(:item_category_id => sub_categories.pluck(:id)) 
      render_json({:msg => "All the items that belongs to category.", :success => true, :items => @itmes}.to_json)
    else
      render_json({:msg => "All the items that belongs to category.", :success => false}.to_json)
    end
  end
  
  def sub_category_items
    sub_category = ItemCategory.find_by(:id => params[:sub_category_id])
    if sub_category
      @items = sub_category.items 
      render_json({:msg => "All the items that  belongs to sub category.", :success => true, :items => @itmes}.to_json)
    else
      render_json({:msg => "All the items that  belongs to sub category.", :success => false}.to_json)
    end
  end
  
end
