class SchedulersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @disponible_days = Scheduler.disponible_days
    @scheduler = Scheduler.new
  end

  def create
    parsed_time = DateTime.strptime(scheduler_params[:date], '%d/%m/%y %H') + 3.hours
    Scheduler.create!(date: parsed_time)
    redirect_to schedulers_url, notice: 'Agendado com sucesso!'
  rescue
    redirect_to schedulers_url, notice: 'Não foi possível efetuar o agendamento!'
  end

  private

  def scheduler_params
    params.require(:scheduler).permit(:date)
  end
end