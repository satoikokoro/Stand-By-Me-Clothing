class Color < ApplicationRecord
  has_many :cloth_colors
  has_many :clothes, through: :cloth_colors
end


