class RecipetsController < ApplicationController
  before_action :require_login
  before_action :set_recipet, only: %i[show edit update destroy]

  def index
    @recipets = current_user.recipets
  end

  def new
    @recipet = Recipet.new
  end

  def create
    @recipet = current_user.recipets.build(recipet_params)
    recipet_items_data = recipet_items_raw

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

  def edit;end

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
    params.require(:recipet).permit(:purchased_at)
  end

  # 子modelのrecipet_itemsをparamsから取得するためのメソッド
  def recipet_items_raw
    params[:recipet][:recipet_items].values
  end
end
