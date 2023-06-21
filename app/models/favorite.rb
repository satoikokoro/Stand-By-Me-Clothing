class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :cloth
  validates_uniqueness_of :cloth_id, scope: :user_id
end
