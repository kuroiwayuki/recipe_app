class Recipet < ApplicationRecord
  belongs_to :user
  has_many :recipet_items, inverse_of: :recipet, dependent: :destroy
  accepts_nested_attributes_for :recipet_items, allow_destroy: true,
  # 空のフォームを除外
    reject_if: ->(attrs) {
      attrs['quantity'].blank? ||
      attrs.dig('item_attributes', 'name').blank? ||
      attrs.dig('item_attributes', 'category_attributes', 'name').blank?
    }
end

