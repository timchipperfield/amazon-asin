class Product < ApplicationRecord

  validates :asin, presence: true
  validates :category, presence: true
  validates :title, presence: true
  validates :rank, presence: true
end
