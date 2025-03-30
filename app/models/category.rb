class Category < ApplicationRecord
  has_many :categories_desires
  has_many :desires, through: :categories_desires
end
