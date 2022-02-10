class Api::V1::ItemsSearchController < ApplicationController
  def index
    if params[:name]
      items = Item.find_all_items_by_name(params[:name])
      render json: ItemSerializer.new(items)
    elsif params[:min_price] && params[:max_price]
      items = Item.find_all_items_between(params[:min_price], params[:max_price])
      render json: ItemSerializer.new(items)
    elsif params[:max_price]
      items = Item.find_all_items_filter_max(params[:max_price])
      render json: ItemSerializer.new(items)
    elsif params[:min_price]
      items = Item.find_all_items_filter_min(params[:min_price])
      render json: ItemSerializer.new(items)
    end
  end
end
