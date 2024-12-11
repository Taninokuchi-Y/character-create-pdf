class CharactersController < ApplicationController

  def index
    @characters = Character.all.order(created_at: :desc)
  end

  def new
    @character = Character.new
    @skills = Skill.all
    @skills.each do |skill|
      @character.character_skills.build(skill: skill, value: skill.default_value)
    end
  end

  def create
    @character = Character.new(character_params)
    if @character.save
      redirect_to root_path
    else
      @skills = Skill.all
      @character.character_skills.build(@skills.map { |skill| { skill: skill, value: skill.default_value } })
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @character = Character.find(params[:id])
    if @character.update(character_params)
      render json: { character: @character, message: "Updated successfully!" }
    else
      render json: { errors: @character.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def character_params
    params.require(:character).permit(
      :name, :furigana, :job, :age, :gender, :from, :possession, :memo,
      :str, :con, :dex, :app, :siz, :int, :edu,
      character_skills_attributes: [:skill_id, :value],
      custom_skills: {}
      )
      .merge(user_id: current_user.id)
  end
end
