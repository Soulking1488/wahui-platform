class BoardsController < ApplicationController
  def index
    @boards = Board.includes(:synonyms).where(active: true).order(:id)
  end
end
