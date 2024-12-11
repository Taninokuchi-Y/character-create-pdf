class Character < ApplicationRecord
  validates :name,       presence: true
  validates :str,        presence: true
  validates :con,        presence: true
  validates :dex,        presence: true
  validates :app,        presence: true
  validates :siz,        presence: true
  validates :int,        presence: true
  validates :edu,        presence: true

  belongs_to :user
  has_many :character_skills, dependent: :destroy
  has_many :skills, through: :character_skills

  accepts_nested_attributes_for :character_skills, allow_destroy: true

  # 使用可能ポイントを計算するメソッド
  def available_points
    (edu.to_i * 20) + (int.to_i * 10) # EDUとINTの値に基づいて計算
  end

  # 残りポイントを計算するメソッド
  def remaining_points
    total_used_points = 0 #技能の初期値合計

    character_skills.each do |cs|
      total_used_points += cs.value.to_i
    end

    available_points - total_used_points
  end
end

