class RecipetsController < ApplicationController
  before_action :require_login
  before_action :set_recipet, only: %i[show edit update destroy]

  def index
    @recipets = current_user.recipets
  end

  def new
    @recipet = Recipet.new
    ri = @recipet.recipet_items.build
    item = ri.build_item
    item.build_category
  end


  def create
    @recipet = current_user.recipets.build(recipet_params)
    binding.pry

    if @recipet.save
      redirect_to @recipet, notice: "レシート内容を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end


  def show;end

  def edit
    @recipet = Recipet.find(params[:id])
  end

  def update
    @recipet = Recipet.find(params[:id])
    binding.pry
    @recipet.assign_attributes(recipet_params)
    if @recipet.save
      redirect_to @recipet, notice: "レシートを更新しました"
    else
      render :edit
    end
  end


  def destroy
    @recipet.destroy
    redirect_to recipets_path, notice: "レシート内容を削除しました"
  end

  private

  def set_recipet
    @recipet = current_user.recipets.find(params[:id])
  end

  def recipet_params
    params.require(:recipet).permit(
      :purchased_at,
      recipet_items_attributes: [
        :id,
        :quantity,
        :_destroy,
        item_attributes: [
          :id,
          :name,
          category_attributes: [ :id, :name ]
        ]
      ]
    )
  end
end
