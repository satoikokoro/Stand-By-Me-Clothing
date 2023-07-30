class Genre < ApplicationRecord
  has_many :cloths, dependent: :destroy

  validates :name, uniqueness: true, presence: true

end
