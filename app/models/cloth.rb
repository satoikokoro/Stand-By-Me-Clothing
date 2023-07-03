class Cloth < ApplicationRecord
  belongs_to :genre
  belongs_to :storage
  belongs_to :user

  has_many :cloth_colors
  has_many :colors, through: :cloth_colors
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :color_properties, dependent: :destroy

  has_one_attached :image

    # Activestorage メソット
    def get_cloth_image(width, height)
      unless image.attached?
        file_path = Rails.root.join('app/assets/images/cloth_no_image.jpg')
        image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
    image
    end

  #引数で渡されたユーザidがFavoritesテーブル内に存在していればtrue、存在していなければfalseを返す
    def favorited_by?(user)
      favorites.exists?(user_id: user.id)
    end

  # 衣類のキーワード検索 条件分岐
  def self.search_for(content, method)
    if method == 'perfect'
      Cloth.where(name: content)
    elsif method == 'forward'
      Cloth.where('name LIKE ?', content+'%')
    elsif method == 'backward'
      Cloth.where('name LIKE ?', '%'+content)
    else
      Cloth.where('name LIKE ?', '%'+content+'%')
    end
  end

end
