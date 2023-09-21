class Category < ApplicationRecord
  belongs_to :user
  validates :icon, presence: true
  validates :name, presence: true

  has_many :transactions
end
