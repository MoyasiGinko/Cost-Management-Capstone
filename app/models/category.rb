class Category < ApplicationRecord
  validates :icon, presence: true

  has_many :transactions
end
