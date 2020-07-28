class Merchant::ItemsController < Merchant::BaseController
  def index
    merchant_user = User.find(session[:user_id])
    merchant = merchant_user.merchants.first
    @items = merchant.items
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to "/merchant/items"
    flash[:message] = "#{item.name} has now been deleted"
  end

  def new
  end

  def create
    #require "pry"; binding.pry
    merchant_user = User.find(session[:user_id])
    merchant = merchant_user.merchants.first
    item = merchant.items.create(item_params)
    if item.save
      redirect_to "/merchant/items"
      flash[:message] = "#{item.name} has been created"
    else
      redirect_to "/merchant/items/new"
      flash[:error] = item.errors.full_messages.to_sentence
    end
  end

  private
  def item_params
    params.permit(:name,:description,:price,:inventory,:image)
  end

end
