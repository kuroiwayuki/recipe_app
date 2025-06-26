class RecipetItemsController < ApplicationController
  before_action :set_recipet_item

  def edit
  end

  def update
    if @recipet_item.update(recipet_item_params)
      redirect_to edit_recipet_path(@recipet_item.recipet), notice: '商品情報を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipet_item = RecipetItem.find(params[:id])
    @recipet_item.destroy
  
    respond_to do |format|
      format.turbo_stream 
      format.html { redirect_to edit_recipet_path(@recipet_item.recipet), notice: "削除しました" }
    end
  end
  private

  def set_recipet_item
    @recipet_item = RecipetItem.find(params[:id])
  end

  def recipet_item_params
    params.require(:recipet_item).permit(:quantity, :price)
  end
end
