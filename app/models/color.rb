class Color < ApplicationRecord
  has_many :cloth_colors
  has_many :cloths, through: :cloth_colors

  validates :name, uniqueness: true, presence: true

end