class Genre < ApplicationRecord

  has_many :clothes, dependent: :destroy

  validates :name, uniqueness: true, presence: true

end
