class Recipet < ApplicationRecord
  belongs_to :user
  has_many :recipet_items, dependent: :destroy
end
