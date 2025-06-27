class RecipetItem < ApplicationRecord
  belongs_to :recipet
  belongs_to :item
  accepts_nested_attributes_for :item
end
