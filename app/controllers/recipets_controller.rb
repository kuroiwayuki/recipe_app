class RecipetsController < ApplicationController
  before_action :require_login
  before_action :set_recipet, only: %i[show edit update destroy]

  def index
    @recipets = current_user.recipets
  end

  # newページからのアイテム追加
  # def add_item
  #   item_name = params[:item_name]
  #   @quantity = params[:quantity].to_i
  #   @price = params[:price].to_i

  #   default_category = Category.find_or_create_by(name: "未分類")
  #   @item = Item.find_or_create_by(name: item_name) do |item|
  #     item.unit = "個"
  #     item.category = default_category
  #   end

  #   respond_to do |format|
  #     format.turbo_stream
  #   end
  # end

  # editページからの新規アイテム追加に関する処理
  # def add_item_from_edit
  #   @recipet = Recipet.find(params[:recipet_id])
  #   @item = Item.find_or_create_by(name: params[:item_name])

  #   # カテゴリの付与のロジックは今後考えるので、一旦未分類に
  #   # おそらくキーワード辞書でカテゴリを付与することになる
  #   # ただし、未分類のカテゴリがない場合は作成する
  #   if @item.new_record?
  #     @item.category ||= Category.find_or_create_by!(name: "未分類")
  #     @item.save!
  #   end

  #   @quantity = params[:quantity].to_i

  #   @recipet_item = @recipet.recipet_items.build(item: @item, quantity: @quantity)

  #   respond_to do |format|
  #     format.turbo_stream
  #   end
  # end

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
