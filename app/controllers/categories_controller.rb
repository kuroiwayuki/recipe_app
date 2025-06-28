class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
    @category = params[:id] ? Category.find(params[:id]) : Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "カテゴリを作成しました"
    else
      @categories = Category.all
      render :index
    end
  end

  def edit
    # index の一覧から編集する形式なので、通常は不要
    redirect_to categories_path(id: @category.id)
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: "カテゴリを更新しました"
    else
      @categories = Category.all
      render :index
    end
  end

  def destroy
    binding.pry
    @category.destroy
    redirect_to categories_path, notice: "カテゴリを削除しました"
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :default_expiration)
  end
end
