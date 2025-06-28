class Category < ApplicationRecord
  has_many :items

  before_destroy :reassign_items_to_default

  private
  # カテゴリ削除時、該当item全てを未分類カテゴリに割り当て
  def reassign_items_to_default
    default_category = Category.find_by(name: "未分類") || Category.first
    items.update_all(category_id: default_category.id)
  end
end
