class RecipetItem < ApplicationRecord
  belongs_to :recipet
  belongs_to :item
  before_validation :set_expired_at
  accepts_nested_attributes_for :item
  
  # 購入日とカテゴリーの賞味期限からrecipet_itemのexpired_atを設定する
  def set_expired_at
    return if expired_at.present? || recipet.blank? || item.blank? || item.category.blank?
    self.expired_at = recipet.purchased_at + item.category.default_expiration.days
  end
  
end
