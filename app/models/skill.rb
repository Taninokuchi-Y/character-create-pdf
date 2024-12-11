class Skill < ApplicationRecord
  has_many :character_skills
  has_many :characters, through: :character_skills

  validates :name, presence: true
  validates :default_value, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
