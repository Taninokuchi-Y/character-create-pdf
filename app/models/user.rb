class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name,            presence: true
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]{8,128}+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message:"英字と数字を含む8文字以上で入力してください"

  has_many :characters, dependent: :destroy
end
