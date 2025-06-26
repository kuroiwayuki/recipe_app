class RecipetsController < ApplicationController
  before_action :require_login
  before_action :set_recipet, only: %i[show edit update destroy]

  def index
    @recipets = current_user.recipets
  end

  def add_item
    item_name = params[:item_name]
    @quantity = params[:quantity].to_i
    @price = params[:price].to_i

    default_category = Category.find_or_create_by(name: "未分類")
    @item = Item.find_or_create_by(name: item_name) do |item|
      item.unit = "個"
      item.category = default_category
    end

    respond_to do |format|
      format.turbo_stream
    end
  end

  def new
    @recipet = Recipet.new
  end

  def create
    @recipet = current_user.recipets.build(recipet_params.except(:recipet_items))
    recipet_items_data = recipet_params[:recipet_items]

    if @recipet.save
      recipet_items_data.each do |item_data|
        @recipet.recipet_items.create(
          item_id: item_data[:item_id],
          quantity: item_data[:quantity]
        )
      end

      redirect_to @recipet, notice: "レシートを登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show;end

  def edit
    @recipet = current_user.recipets.find(params[:id])
  end

  def update
    if @recipet.update(recipet_params)
      redirect_to @recipet, notice: "レシートを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipet.destroy
    redirect_to recipets_path, notice: "レシートを削除しました"
  end

  private

  def set_recipet
    @recipet = current_user.recipets.find(params[:id])
  end

  def recipet_params
    params.require(:recipet).permit(
      :purchased_at,
      recipet_items: [ :item_id, :quantity, :price ]
    )
  end
end
