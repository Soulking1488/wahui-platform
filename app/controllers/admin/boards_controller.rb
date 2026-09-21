module Admin
  class BoardsController < BaseController
    before_action :set_board, only: [:show, :edit, :update]

    def index
      @boards = Board.order(:name)
    end

    def show
    end

    def edit
    end

    def update
      if @board.update(board_params)
        redirect_to admin_board_path(@board), notice: "Board updated successfully."
      else
        render :edit, status: :unprocessable_content
      end
    end

    private

    def set_board
      @board = Board.find(params[:id])
    end

    def board_params
      params.require(:board).permit(:name, :active)
    end
  end
end
