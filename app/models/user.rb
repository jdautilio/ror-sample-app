class User < ApplicationRecord
  has_many :microposts, dependent: :destroy

  has_many :platform_users
  has_many :platforms, through: :platform_users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def feed
    Micropost.where('user_id = ?', id)
  end

  def subscribe(platform)
    platforms << platform
  end

  def unsubscribe(platform)
    platforms.delete platform
  end

  def subscribed?(platform)
    platforms.include? platform
  end
end
