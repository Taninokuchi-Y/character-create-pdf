class Character < ApplicationRecord
  validates :name,       presence: true
  validates :str,        presence: true
  validates :con,        presence: true
  validates :dex,        presence: true
  validates :app,        presence: true
  validates :siz,        presence: true
  validates :edu,        presence: true

  belongs_to :user
  # has_many :skills, through: :character_skills
  # has_many :character_skills
end
