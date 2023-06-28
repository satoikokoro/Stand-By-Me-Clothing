class Storage < ApplicationRecord
  belongs_to :user
  has_many :cloths, dependent: :destroy

  has_one_attached :image

  def get_storage_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/storage_no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

end
