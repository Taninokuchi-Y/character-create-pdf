class CharactersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_character, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @characters = Character.all.order(created_at: :desc)
  end

  def show
    @skills_by_genre = Skill.order(:genre, :name).group_by(&:genre)
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

  def edit
    if @character.custom_skills.present?
      # custom_skillsが文字列の場合、JSON形式に変換して配列にする
      if @character.custom_skills.is_a?(String)
        @character.custom_skills = JSON.parse(@character.custom_skills)
      end
    else
      @character.custom_skills = []
    end
  end

  def update
    # custom_skills がハッシュの配列で送信された場合
    if params[:character][:custom_skills].present?
      # custom_skills を JSON 形式に変換して保存
      params[:character][:custom_skills] = params[:character][:custom_skills].to_json
    end

    if @character.update(character_params)
      redirect_to @character
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @character.destroy
    redirect_to root_path, alert: "キャラクターを削除しました。"
  end

  private

  def character_params
    params.require(:character).permit(
      :name, :furigana, :job, :age, :gender, :from, :possession, :memo,
      :str, :con, :pow, :dex, :app, :siz, :int, :edu,
      character_skills_attributes: [:skill_id, :value],
      custom_skills: [:name, :value]
      )
      .merge(user_id: current_user.id)
  end

  def set_character
    @character = Character.find(params[:id])
  end

  def correct_user
    if @character.user != current_user
      redirect_to root_path, alert: "この操作は許可されていません。"
    end
  end

end
