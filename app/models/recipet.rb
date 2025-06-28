class Recipet < ApplicationRecord
  belongs_to :user
  has_many :recipet_items, dependent: :destroy
  accepts_nested_attributes_for :recipet_items, allow_destroy: true, reject_if: :blank_recipet_item

  # reject_if切り出し
  def blank_recipet_item(attrs)
    binding.pry
    attrs["quantity"].blank? ||
    attrs.dig("item_attributes", "name").blank? ||
    attrs.dig("item_attributes", "category_id").blank?
  end
end
