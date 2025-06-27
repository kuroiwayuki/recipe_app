class Item < ApplicationRecord
  has_many :recipet_items
  belongs_to :category
  accepts_nested_attributes_for :category
end
