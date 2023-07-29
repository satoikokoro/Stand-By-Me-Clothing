class Comment < ApplicationRecord
belongs_to :user
belongs_to :cloth

validates :comment, presence: true, length:{maximum:420}

end
