module Admin
  class WahuiboardsController < BaseController
    before_action :set_wahuiboard, only: [:show, :edit, :update, :destroy]

    def index
      @status_filter = params[:status].presence || "all"
      @wahuiboards = Wahuiboard.includes(:board).order(:public_number)
      @wahuiboards = @wahuiboards.where(status: @status_filter) unless @status_filter == "all"
      @status_summary = Wahuiboard.statuses.keys.index_with { |status| Wahuiboard.where(status: status).count }
      @status_summary["all"] = Wahuiboard.count
    end

    def show
    end

    def new
      @wahuiboard = Wahuiboard.new(
        status: :draft,
        opens_at: Time.current + 1.hour,
        betting_closing_time: Time.current + 2.hours,
        announcement_time: Time.current + 3.hours,
        house_bet_amount: 0
      )
    end

    def create
      @wahuiboard = Wahuiboard.new(wahuiboard_params)

      if @wahuiboard.save
        redirect_to admin_wahuiboard_path(@wahuiboard), notice: "Round draft created successfully."
      else
        render :new, status: :unprocessable_content
      end
    end

    def edit
    end

    def update
      if @wahuiboard.update(wahuiboard_params)
        redirect_to admin_wahuiboard_path(@wahuiboard), notice: "Round draft updated successfully."
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @wahuiboard.destroy
      redirect_to admin_wahuiboards_path, notice: "Round removed successfully."
    end

    private

    def set_wahuiboard
      @wahuiboard = Wahuiboard.find(params[:id])
    end

    def wahuiboard_params
      params.require(:wahuiboard).permit(
        :title,
        :public_number,
        :status,
        :board_id,
        :house_bet_board_id,
        :house_bet_amount,
        :description,
        :opens_at,
        :betting_closing_time,
        :announcement_time,
        :clue_1,
        :clue_2,
        :clue_3,
        :clue_4
      )
    end
  end
end
