class Cloth < ApplicationRecord
  belongs_to :genre, optional: true
  belongs_to :storage, optional: true
  belongs_to :user

  has_many :cloth_colors
  has_many :colors, through: :cloth_colors
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :color_properties, dependent: :destroy

  #衣類投稿での投稿制限
  validates :name, presence:true,length:{maximum:20}
  validates :description,length:{maximum:150}
  validates :genre_id, presence:true
  validates :storage_id, presence:true
  validates :privacy_status, presence:true


  #投稿の公開・非公開のstatusカラムの設定
    enum privacy_status: { public: 0, private: 1 },_prefix: true

  # Activestorage メソット
    has_one_attached :image
    def get_cloth_image(width, height)
      unless image.attached?
        file_path = Rails.root.join('app/assets/images/cloth_no_image.jpg')
        image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
    image
    end

  #引数で渡されたユーザidがいいねテーブル内に存在していればtrue、存在していなければfalseを返す
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