class Cloth < ApplicationRecord
  belongs_to :genre
  belongs_to :storage
  
  has_many :cloth_colors
  has_many :colors, through: :cloth_colors
  
end
