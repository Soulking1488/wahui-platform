class RoundsController < ApplicationController
  def index
    @upcoming_rounds = Wahuiboard.includes(:board).where(status: [:scheduled, :open]).order(:opens_at).map { |round| round_card(round) }
    @results = Wahuiboard.includes(:board).where(status: [:announced, :settled]).order(announced_at: :desc).map { |round| result_card(round) }
    @preview_mode = @upcoming_rounds.empty? && @results.empty?

    if @preview_mode
      @upcoming_rounds = preview_upcoming_rounds
      @results = preview_results
    end
  end

  private

  def round_card(round)
    {
      number: round.public_number,
      title: round.title,
      status: round.status,
      opens_at: round.opens_at,
      closes_at: round.betting_closing_time,
      announces_at: round.announcement_time,
      board_count: 20
    }
  end

  def result_card(round)
    {
      number: round.public_number,
      title: round.title,
      announced_at: round.announced_at || round.announcement_time,
      board: round.board,
      status: round.status
    }
  end

  def preview_upcoming_rounds
    [
      {
        number: 102,
        title: "Evening Round",
        status: "scheduled",
        opens_at: 2.hours.from_now,
        closes_at: 3.hours.from_now,
        announces_at: 3.hours.from_now + 15.minutes,
        board_count: 20,
        preview: true
      },
      {
        number: 103,
        title: "Night Round",
        status: "scheduled",
        opens_at: 5.hours.from_now,
        closes_at: 6.hours.from_now,
        announces_at: 6.hours.from_now + 15.minutes,
        board_count: 20,
        preview: true
      }
    ]
  end

  def preview_results
    [
      {
        number: 101,
        title: "Afternoon Round",
        announced_at: 45.minutes.ago,
        board: Board.find_by(name: "KURA-KURA"),
        status: "settled",
        preview: true
      },
      {
        number: 100,
        title: "Morning Round",
        announced_at: 4.hours.ago,
        board: Board.find_by(name: "IKAN BESAR"),
        status: "settled",
        preview: true
      }
    ]
  end
end
