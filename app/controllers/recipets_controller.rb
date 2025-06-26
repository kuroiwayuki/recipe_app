class RecipetsController < ApplicationController
  before_action :require_login
  before_action :set_recipet, only: %i[show edit update destroy]

  def index
    @recipets = current_user.recipets
  end

  #newページからのアイテム追加
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

  #editページからの新規アイテム追加に関する処理
  def add_item_from_edit
    @recipet = Recipet.find(params[:recipet_id])
    @item = Item.find_or_create_by(name: params[:item_name])

    #カテゴリの付与のロジックは今後考えるので、一旦未分類に
    #おそらくキーワード辞書でカテゴリを付与することになる
    #ただし、未分類のカテゴリがない場合は作成する
    if @item.new_record?
      @item.category ||= Category.find_or_create_by!(name: "未分類")
      @item.save!
    end

    @quantity = params[:quantity].to_i
  
    @recipet_item = @recipet.recipet_items.build(item: @item, quantity: @quantity)
  
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
    @recipet = Recipet.find(params[:id])
    
  
    # attribute_nestedを使用しないため、子モデル（recipet_items）の更新を手動で行う
    # 既存のrecipet_itemsを取得し、該当するitemは追加せず、含まれていないitemのみDBに追加
    existing_item = @recipet.recipet_items.pluck(:item_id).map(&:to_s)
    binding.pry
    params[:recipet][:recipet_items].each do |item_param|
    # 判別の条件分岐箇所
      unless existing_item.include?(item_param[:item_id])
        @recipet.recipet_items.build(
          item_id: item_param[:item_id],
          quantity: item_param[:quantity]
        )
      end
    end
    if @recipet.save
      redirect_to @recipet, notice: "レシート内容を更新しました"
    else
      render :edit, status: :unprocessable_entity
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
      recipet_items: [ :item_id, :quantity, :price ]
    )
  end
end
