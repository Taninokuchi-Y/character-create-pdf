class CharactersController < ApplicationController

  def index
    @characters = Character.all.order(created_at: :desc)
  end

end
