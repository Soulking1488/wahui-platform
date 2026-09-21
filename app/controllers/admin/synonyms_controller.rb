module Admin
  class SynonymsController < BaseController
    before_action :set_board, only: [:index, :new, :create, :edit, :update, :destroy]
    before_action :set_synonym, only: [:edit, :update, :destroy]

    def catalog
      @boards = Board.includes(:synonyms).order(:name)
    end

    def index
      @synonyms = @board.synonyms.order(:word)
    end

    def new
      @synonym = @board.synonyms.new
    end

    def create
      @synonym = @board.synonyms.new(synonym_params)

      if @synonym.save
        redirect_to admin_board_synonyms_path(@board), notice: "Synonym added successfully."
      else
        render :new, status: :unprocessable_content
      end
    end

    def edit
    end

    def update
      if @synonym.update(synonym_params)
        redirect_to admin_board_synonyms_path(@board), notice: "Synonym updated successfully."
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @synonym.destroy!
      redirect_to admin_board_synonyms_path(@board), notice: "Synonym removed successfully."
    end

    private

    def set_board
      @board = Board.find(params[:board_id])
    end

    def set_synonym
      @synonym = @board.synonyms.find(params[:id])
    end

    def synonym_params
      params.require(:synonym).permit(:word, :mapping)
    end
  end
end
