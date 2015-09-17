class SchedulersController < ApplicationController

  def index
    day_of_week = Time.now.strftime("%u").to_i

    week_schedule = Scheduler.where("date >= ? and date <= ?", Time.now, Time.now + (5 - day_of_week).days).pluck(:date)

    @disponible_days = []

    week_schedule.each do |day|
      @disponible_days << "#{day.strftime("%u").to_i}/#{day.strftime("%H").to_i}"
    end

    @scheduler = Scheduler.new
  end

  def create
    parsed_time = DateTime.strptime(scheduler_params[:date], '%d/%m/%y %H')
    Scheduler.create!(date: parsed_time)
    redirect_to schedulers_url, notice: 'Agendado com sucesso!'
  rescue => e
    redirect_to schedulers_url, notice: 'Não foi possível efetuar o agendamento!'
  end

  private

  def scheduler_params
    params.require(:scheduler).permit(:date)
  end
end