class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :purchase, :done, :destroy, :pay]
  before_action :authenticate_user!, only:[:purchase, :pay, :done]
  before_action :set_image, only:[:show, :purchase,:pay]
  before_action :set_card, only:[:purchase, :pay]
  require "payjp"

  def index
    @items = Item.all.includes(:images).where(status_id: "1").order(created_at: :desc)
    @parents = Category.where(ancestry: nil)
  end
  
  def new
    @item = Item.new
  end
    
  def create
    @item = Item.new(item_params)
    if  @item.save
      redirect_to roots_path, notice: "出品しました"
    else
      redirect_to  new_item_path, notice: "出品できません。入力必須項目を確認してください"
    end
  end

  def edit
  end
   
  def update
  end

  def destroy
    if @item.destroy
      redirect_to root_path, notice: "削除が完了しました"
    else
      redirect_to root_path, alert: "削除に失敗しました"
    end
  end
  
  def show
    @parents = Category.where(ancestry: nil)
  end

  def purchase
    if @item.user_id == current_user.id
      redirect_to root_path   
    else
      unless @item.status_id == "1"
        redirect_to root_path, notice: "購入済みです"
      end
      if @card.blank?
        flash[:alert] = '購入前にクレジットカードの登録をしてください'
        redirect_to creditcards_path
     else
        @address = Address.where(user_id: current_user.id).first
        Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
        customer = Payjp::Customer.retrieve(@card.customer_id) 
        @default_card_information = customer.cards.retrieve(@card.card_id)
      end
    end
  end

<<<<<<< HEAD
=======
  def pay
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
    Payjp::Charge.create(
      amount: @item.price,
      customer: @card.customer_id,
      currency: 'jpy',
    )
    @item.update(status_id: BUYING_STATUS, buyer_id: current_user.id)
    redirect_to done_item_path
  end
  
  def done
  end  

  def set_images
    @images = Image.where(item_id: params[:id])
  end
  
  def set_image
    @item_images = @item.images
    @image = @item_images.first
  end
  
>>>>>>> origin
  private
  def item_params
    params.require(:item).permit(:name, :descripton, :condition,:prefecture,:size,:price,:shipping_days,:postage,:user_id,:category_id,:brand_id,images_attributes: [:url, :item_id]).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])

    begin
      @item = Item.find(params[:id])
    rescue
      redirect_to root_path
    end
  end

  def set_card
    @card = Creditcard.find_by(user_id: current_user.id)
  end
end
