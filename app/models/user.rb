class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cloths, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :storages, dependent: :destroy

  #ニックネーム,プロフィールの文字制限
  validates :name, presence:true, length:{maximum:20}
  validates :introduction, presence:true, length:{maximum:200}

  #activeであればtrueを返すdeviseメソット
   def active_for_authentication?
     super && !is_deleted?
   end
  #条件演算子でメッセージを選択
  def inactive_message
    is_deleted? ? :account_inactive : super
  end

  #Activestorage メソット
  has_one_attached :image
  def get_user_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/user_no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  #ユーザー検索の条件分岐
  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end

#ゲストログインメソット定義

GUEST_USER_EMAIL = "guest@example.com"


def self.guest
  find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
    user.password = SecureRandom.urlsafe_base64
    user.name ='guestuser'
    user.introduction = ' '
  end
end

end