class Recipet < ApplicationRecord
  belongs_to :user
  has_many :recipet_items, dependent: :destroy
  accepts_nested_attributes_for :recipet_items, allow_destroy: true, reject_if: :all_blank
end

