class CartController < ApplicationController
  def add_item
    item = Item.find(params[:item_id])
    cart.add_item(item.id.to_s)
    flash[:success] = "#{item.name} was successfully added to your cart"
    redirect_to "/items"
  end

  def show
    @items = cart.items
    if current_admin?
      render file: "public/404"
    end
  end

  def empty
    session.delete(:cart)
    redirect_to '/cart'
  end

  def remove_item
    session[:cart].delete(params[:item_id])
    redirect_to '/cart'
  end

  def update
    item = Item.find(params[:item_id])
    if params[:type] == "add"
      cart.add_item(params[:item_id]) unless item.inventory <= cart.contents[item.id.to_s]
    else
      cart.contents[item.id.to_s] -= 1
      session[:cart].delete(params[:item_id]) if cart.contents[item.id.to_s] == 0
    end
    redirect_to '/cart'
  end
end
